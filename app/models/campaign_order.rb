class CampaignOrder < ActiveRecord::Base
  
  attr_accessor :sfdcid, :name, :jira_key, :parent_order

  validates_presence_of :sfdcid
  validates_uniqueness_of :sfdcid

  #has_many :line_items
  #references :opportunities

  #before_save :exists_in_salesforce?
  #before_save :find_or_create_linked_issue

  def opportunity_name
    SalesForce::Opportunity.find(sfdcid).Name
  end

  def opportunity
    SalesForce::Opportunity.find(sfdcid)
  end

  def opportunity_type
    SalesForce::Opportunity.find(sfdcid).Opp_Type_New__c
  end

  # def overview
  #   result = []
  #   Field.initialize
  #   Value::Field.for_campaign_order.each do |f|
  #     result << { f: opportunity[f] }
  #   end
  #   result
  # end

  private

  def exists_in_salesforce?
    logger.debug "\n\n #{self.to_yaml}\n self = #{self.class}\n#{__FILE__}:#{__LINE__}"
    logger.debug "\n\n #{self.sfdcid.to_yaml}\n self.sfdcid = #{self.sfdcid.class}\n#{__FILE__}:#{__LINE__}"
    SalesForce::Opportunity.find(self.sfdcid)
  end

  def import_existing
    importer = Service::OrderImporter.new(self,@sfdcid)
  end

  def find_or_create_linked_issue
    logger.level = Logger::DEBUG
    logger.debug "We're in Order.after_save now {__FILE__}:#{__LINE__}"
    @jira_key = Service::IssueCreator.new(self.sfdcid).jira_key
    self.save
  end

  def self.find_by(*args)
    records = super
    if records.nil? && args[0].keys.include?(:jira_key)
      # TODO: 2014-03-29 make values[0] more robust in case of 2+ argument queries
      jira_key = args[0].values[0]
      k = Jira::Issue.find_by_key(jira_key).first.sfdcid
      o = Service::IssueCreator.new(k).campaign_order
      records = super
    end
    records
  end

  def self.find_or_create_by(*args)
    # copied from self.find_by
    records = super
    if records.nil? && args[0].keys.include?(:jira_key)
      # TODO: 2014-03-29 make values[0] more robust in case of 2+ argument queries
      jira_key = args[0].values[0]
      k = Jira::Issue.find_by_key(jira_key).first.sfdcid
      o = Service::IssueCreator.new(k).campaign_order
      records = super
    end
    records
  end

end
