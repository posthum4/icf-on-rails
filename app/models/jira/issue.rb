module Jira
  class Issue

    class MissingSalesForceOpportunityIDError < StandardError ; end

    attr_accessor :key, :summary, :assignee, :reporter, :sfdcid

    def initialize(j)
      @key            = j.jira_key
      @summary        = j.summary
      @assignee       = j['fields']['assignee']['name'] rescue nil
      @reporter       = j['fields']['reporter']['name'] || nil
      @updated_at     = j.updated.to_datetime
      @created_at     = j.created.to_datetime
      @sfdcid         = ( j.customfield_11862 || nil )
      @campaign_order = CampaignOrder.find_by(sfdcid: sfdcid)
      @fields         = Value::Field.new
      @jira_ref       = j
    end

    def self.find_by_key(jira_key)
      result = []
      Jiralicious.search("key = #{jira_key}").issues.each do |i|
        result << self.new(i)
      end
      result.first
    end

    def self.find_by_campaign_order(co)
      sfdcid = co.sfdcid
      result = []
      Jiralicious.search("\"SalesForce Opportunity ID\" ~ \"#{sfdcid}\"").issues.each do |i|
        result << self.new(i)
      end
      result.first
    end

    def pre_imported?
      !@jira_ref.description.blank?
    end

    def set_field(jirafield,value)
      set_type = @fields.jira_set_type(jirafield)
      case set_type
      when 'name'
        @jira_ref.fields.set_name(jirafield, value)
      when 'decimal'
        @jira_ref.fields.set(jirafield, value.to_f)
      when 'amount'
        v=ViewModel::Amount.new(value)
        @jira_ref.fields.set(jirafield, v.to_usd_f)
      else
        @jira_ref.fields.set(jirafield, value)
      end
      @jira_ref.save
    end

    def pre_imported?
      binding.pry
    end

    def attach_file(rfattmt)
      fileloc="/tmp/#{rfattmt.name}"
      File.open(fileloc, 'wb') { |f| f.write(rfattmt.body) }
      # curl -D- -u {username}:{password} -X POST -H "X-Atlassian-Token: nocheck" -F "file=@{path/to/image}" http://{base-url}/rest/api/2/issue/{issue-key}/attachments
      Rails.logger.debug "Wrote file #{fileloc}"
      result = %x! curl -D- -v -u #{ENV['JIRA_USER']}:#{ENV['JIRA_PASS']} -X POST -H "X-Atlassian-Token: nocheck" -F "file=@#{fileloc}" #{ENV['JIRA_API']}/rest/api/2/issue/#{@key}/attachments !
      Rails.logger.debug "Uploading attachments resulted in #{result.inspect}"
      result
    end

    def self.find_or_create_by_campaign_order(campaign_order,subject=nil)
      j = find_by_campaign_order(campaign_order)
      j = self.create!(campaign_order.sfdcid,type='Media: New Business',subject ) if j.nil?
    end

    def self.create!(sfdcid,type='Media: New Business',subject = "Test created #{Time.now.utc.to_s} by #{__FILE__}", parent_key = nil)
      Rails.logger.level = Logger::DEBUG
      fail MissingSalesForceOpportunityIDError, @subject if sfdcid.nil?
      jlc = Jiralicious::Issue.new()
      Rails.logger.debug "setting #{jlc} to project 11490"
      jlc.fields.set_id("project", "11490") # this is the ICF project. Hardcoded :)
      Rails.logger.debug "setting #{jlc} issue type to 19"
      jlc.fields.set_id("issuetype", Value::IssueType.jira_id(type)) # this is a campaign launch
      Rails.logger.debug "setting #{jlc} summary to " + ENV['CALLOUT']+"#{subject}"
      jlc.fields.set("summary", ENV['CALLOUT']+"#{subject}" )
      # no point in saving before sfdcid gets put in, or it creates duplicates
      Rails.logger.debug "setting #{jlc} sfdcid to #{sfdcid}"
      jlc.fields.set("customfield_11862", sfdcid )
      Rails.logger.debug "Trying to save #{jlc}"
      jlc.save
      j=Jira::Issue.new(jlc)
    end
  end
end
