module Jira
  class Issue

    attr_accessor :key, :summary, :assignee, :reporter, :sfdcid

    def initialize(j)
      @key            = j['key']
      @summary        = j['fields']['summary']
      @assignee       = j['fields']['assignee']['name'] rescue ENV['JIRA_DEFAULT_USER']
      @reporter       = j['fields']['name'] rescue ENV['JIRA_DEFAULT_USER']
      @updated_at     = j['fields']['updated'].to_datetime rescue Time.now
      @created_at     = j['fields']['created'].to_datetime rescue Time.now
      @sfdcid         = ( j['fields']['customfield_11862'] || nil )
      @campaign_order = CampaignOrder.find_by(sfdcid: sfdcid)
      @fields         = Value::Field.new
      @jira_ref       = Jiralicious.search("key=#{@key}").issues.first
    end

    def self.find_by_key(jira_key)
      result = []
      Jiralicious.search("key = #{jira_key}").issues_raw.each do |i|
        result << self.new(i)
      end
      result.first
    end

    def self.find_by_campaign_order(co)
      result = []
      if co.update_io_case && !co.io_case.nil?
        jiraquery = "\"SalesForce Opportunity ID\" ~ \"#{co.sfdcid}\" and text ~ \"#{co.io_case}\" "
      else
        jiraquery = "\"SalesForce Opportunity ID\" ~ \"#{co.sfdcid}\" "
      end
      Jiralicious.search(jiraquery).issues_raw.each do |i|
        result << self.new(i)
      end

      bestguess = nil
      result.each do |j|
        if j.sfdcid == co.sfdcid
          bestguess = j
        end
      end
      return bestguess # only one result expected
    end

    def save
      @jira_ref.save!
    end

    def set_field(jirafield,value)
      set_type = @fields.jira_set_type(jirafield)
      case set_type
      when 'name'
        begin
          @jira_ref.fields.set_name(jirafield, value)
          @jira_ref.save
        rescue Jiralicious::TransitionError
          @jira_ref.fields.set_name(jirafield, ENV['JIRA_DEFAULT_USER'])
        end
      when 'decimal'
        @jira_ref.fields.set(jirafield, value.to_f)
      when 'amount'
        v=ViewModel::Amount.new(value)
        @jira_ref.fields.set(jirafield, v.to_usd_f.to_f)
      else
        @jira_ref.fields.set(jirafield, value)
      end
      @jira_ref.save
    end

    # not using this for now, just checking in the importer file if there is a JIRA key or not
    def pre_imported?
      !(@jira_ref.description.nil?) and
      @jira_ref.description.include? "CurrencyIsoCode" and
      @jira_ref.description.include? "Campaign Start Date"
    end

    def attach_file(rfattmt)
      fileloc="/tmp/#{rfattmt.name}"
      # File.open(fileloc, 'wb') { |f| f.write(rfattmt.body) }
      # # curl -D- -u {username}:{password} -X POST -H "X-Atlassian-Token: nocheck" -F "file=@{path/to/image}" http://{base-url}/rest/api/2/issue/{issue-key}/attachments
      # Rails.logger.debug "Wrote file #{fileloc}"
      result = %x! curl -D- -v -u #{ENV['JIRA_USER']}:#{ENV['JIRA_PASS']} -X POST -H "X-Atlassian-Token: nocheck" -F "file=@#{fileloc}" #{ENV['JIRA_API']}/rest/api/2/issue/#{@key}/attachments !
      Rails.logger.debug "Uploading attachments resulted in #{result.inspect}"
      result
    end

    def self.find_or_create_by_campaign_order(campaign_order,subject=nil)
      j = find_by_campaign_order(campaign_order)
      j = self.create!(campaign_order.sfdcid,type='Media: New Business',subject ) if j.nil?
      j
    end

    def self.create!(sfdcid,type='Media: New Business',subject = "Test created #{Time.now.utc.to_s} by #{__FILE__}", parent_key = nil)
      fail MissingSalesForceOpportunityIDError, @subject if sfdcid.nil?
      jlc = Jiralicious::Issue.new()
      Rails.logger.debug "setting #{jlc} to project 11490"
      jlc.fields.set_id("project", "11490") # this is the ICF project. Hardcoded :)
      Rails.logger.debug "setting #{jlc} issue type to 19"
      jlc.fields.set_id("issuetype", Value::IssueType.jira_id(type)) # this is a campaign launch
      Rails.logger.debug "setting #{jlc} summary to #{subject}"
      jlc.fields.set("summary", subject )
      # no point in saving before sfdcid gets put in, or it creates duplicates
      Rails.logger.debug "setting #{jlc} sfdcid to #{sfdcid}"
      jlc.fields.set("customfield_11862", sfdcid )
      Rails.logger.debug "Trying to save #{jlc}"
      jlc.save
      Rails.logger.debug "Saved #{jlc.jira_key}"
      j=Jira::Issue.find_by_key(jlc.jira_key)
    end
  end
end
