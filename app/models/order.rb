# encoding: utf-8
require 'csv'
class CreatingDuplicateError < StandardError ; end
class NonExistingOpportunityError < StandardError ; end
class NoAttachmentsError < StandardError ; end

# Class representing both a SalesForce Opportunity and
# a JIRA Integrated Campaign Flow case
class Order < ActiveRecord::Base

  set_primary_key :sfdcid
  # validates :sfdcid, presence: true
  #  validates :sfdcid, format: { with: /(0068000000\w{5,})/ }

  # rubocop:disable AlignHash
  SFDC = Restforce.new username: ENV['SFDC_USERNAME'],
    password:       ENV['SFDC_PASSWORD'],
    security_token: ENV['SFDC_SECURITY_TOKEN'],
    client_id:      ENV['SFDC_CLIENT_ID'],
    client_secret:  ENV['SFDC_CLIENT_SECRET']
  # rubocop:enable all

  FIELDS = CSV.read("#{Rails.root.to_s}/app/models/fields.csv", headers: true)

  Jiralicious.configure do |config|
    config.username =     ENV['JIRA_USER']
    config.password =     ENV['JIRA_PASS']
    config.uri =          ENV['JIRA_API']
    config.api_version = 'latest'
    config.auth_type =   :basic
  end

  # def self.new_by_sfdcid(o)
  #   # TODO: this needs to become a factory method of the inhereting classes
  #   # @sfdcid     = o['Id']
  #   # @name     = o['Name']
  #   object =  case o['Opp_Type_New__c']
  #   when 'Media: Renewal'
  #     Renewal.allocate
  #     # when 'Media: Budget Change'
  #     #   Incremental.allocate
  #   else
  #     NewBusiness.allocate
  #   end
  #   object.send :initialize, o
  #   object
  # end

  # def initialize(o=nil)
  #   unless o.nil?
  #     # logger.level = Logger::DEBUG
  #     # logger.debug "\n\n #{o}\n o = #{o.class}\n#{__FILE__}:#{__LINE__}"
  #     # TODO: check in SFDC documentation if the first 15 chars is reliable
  #     FIELDS.select { |f| f['Object'] == 'Order' }.each do |f|
  #       if f['SalesForce'].include? '.'
  #         var = import_complex(f['SalesForce'], o)
  #       else
  #         var = o[f['SalesForce']]
  #       end
  #       # if ( f['Type'] == 'Date' || f['Type'] == 'DateTime' )
  #       #   instance_variable_set("@#{f['Internal']}", Chronic::parse(var))
  #       # else
  #       instance_variable_set("@#{f['Internal']}", var)
  #       # end
  #     end
  #     @sfdcid         = o['Id'][0..14]
  #   end
  #   save!
  # end

  def to_jira
    ## investgigate if exists already
    #logger.debug "\n\n #{self.to_yaml}\n self = #{self.class}\n#{__FILE__}:#{__LINE__}"
    result = jira_key
  end

  def subject
    # ICF field: Summary
    case @opp_type_new
    when 'Media: New Business', 'Enterprise: New Business'
      mymarker = 'Launch'
    else
      mymarker = 'Change'
    end
    "#{ENV['CALLOUT']}#{mymarker} #{@name} due #{@campaign_start_date}"
  end

  def find_or_create_jira_key
    fail NotImplementedError
  end

  def import_complex(sffield, oppt)
    # logger.level = Logger::DEBUG
    # logger.debug "oppt = #{oppt.class} #{oppt.inspect}"
    f1, f2 = sffield.split('.')
    # logger.debug "f1 = #{f1.class} #{f1.inspect}"
    # logger.debug "f2 = #{f2.class} #{f2.inspect}"
    if oppt[f1].nil?
      var = nil
    else
      var = oppt[f1][f2]
      var.include?('@rocketfuel.com') ? var.sub!('@rocketfuel.com', '') : var
    end
    # logger.debug "var = #{var.class} #{var.inspect}"
    var
  end

  def self.find(opportunity_id)
    # TODO: 2014-03-02 first check if this is in the database already
    # e.g. split up in Order.find and self.import
    f = FIELDS['SalesForce'].select { |x| !x.nil? }.join(',')
    # logger.devel "f = #{f.class} #{f.inspect}"
    soql = %Q(
      select #{f} from Opportunity where Id='#{opportunity_id}'
    )
    # logger.devel "soql = #{soql.class} #{soql.inspect}"
    o = SFDC.query(soql).first
    # logger.devel "o = #{o.class} #{o.inspect}"
    new_by_sfdcid(o) unless o.nil?
  end

  def in_jira?
    !jira_key.nil?
  end

  def linked_jira
    q = %Q(
      project=ICF and ( "SalesForce Opportunity ID" ~ "#{@sfdcid}"
                        OR description ~ "#{@sfdcid}" )
    )
    result = Jiralicious.search(q).issues
    if result.size > 0
      result.first
    else
      nil
    end
  end

  def jira_key
    k = @stored_jira_key
    if k.nil?
      l = linked_jira
      if l.nil?
        k = nil
      else
        k = l.jira_key
      end
    end
    k
  end

  def find_or_create_jira
    linked_jira.nil? ? create_jira : linked_jira
  end

  def to_s
    "#{@sfdcid} #{@stored_jira_key} #{@amount} #{@opp_type_new} #{@name}"
  end

  def io_case_id
    if @io_case.nil?
      soql = %Q(select Id from Case where Opportunity__c = '#{@sfdcid}'
                order by LastModifiedDate limit 1)
      @io_case = SFDC.query(soql).first['Id']
    end
    @io_case
  end

  def attachments(days = 7)
    soql = %Q(
      select Id,Name,ContentType,Body from Attachment where
      ParentId = '#{io_case_id}' and LastModifiedDate=LAST_N_DAYS:#{days}
    )
    logger.debug "\n\n #{soql}\n soql = #{soql.class}\n#{__FILE__}:#{__LINE__}"
    result = SFDC.query(soql)
    if result.to_a.count == 0
      fail NoAttachmentsError, "Attachments for #{@sfdcid} not found"
    end
    result
  end

  def copy_attachments(jira)
    # TODO: 2014-03-02 separate attachments into their own objects
    # NOTE: keep this before assigning it or people get pinged per file
    attachments.each do |a|
      jira.attach_file(a)
      logger.info "Attached file #{a['Name']}"
      jira.save!
    end
  rescue Exception => e
    logger.warn e.message
  end


  def save_corefields(j)

  end
  def save_description(j)

  end
  def save_salesfuel(j)

  end
  def save_assignees(j)
  end

end
