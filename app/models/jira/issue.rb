module Jira
  class Issue

    attr_accessor :key, :summary, :assignee, :reporter, :sfdcid

    def initialize(j)
      @key            = j.jira_key
      @summary        = j.summary
      @assignee       = j['fields']['assignee']['name'] rescue nil
      @reporter       = j['fields']['reporter']['name'] || nil
      @updated_at     = j.updated.to_datetime
      @created_at     = j.created.to_datetime
      @sfdcid         = j.customfield_11862
      @campaign_order = CampaignOrder.find_by(sfdcid: sfdcid)
      @fields         = Value::Field.new
      @jira_ref       = j
    end

    def self.find_by_key(jira_key)
      result = []
      Jiralicious.search("key = #{jira_key}").issues.each do |i|
        result << self.new(i)
      end
      result
    end

    def self.find_by_sfdcid(sfdcid)
      result = []
      Jiralicious.search("\"SalesForce Opportunity ID\" ~ \"#{sfdcid}\"").issues.each do |i|
        result << self.new(i)
      end
      result
    end

    def save
      @jira_ref.save!
    end

    def set_field(jirafield,value)
      set_type = @fields.jira_set_type(jirafield)
      case set_type
      when 'name'
        @jira_ref.fields.set_name(jirafield, value)
      when 'decimal'
        @jira_ref.fields.set(jirafield, value.to_f)
      when 'money'
        @jira_ref.fields.set(jirafield, value.as_us_dollar.amount)
      else
        @jira_ref.fields.set(jirafield, value)
      end
      @jira_ref.save
    end

    def attach_file(rfattmt)
      fileloc="/tmp/#{rfattmt.name}"
      File.open(fileloc, 'wb') { |f| f.write(rfattmt.body) }
      # curl -D- -u {username}:{password} -X POST -H "X-Atlassian-Token: nocheck" -F "file=@{path/to/image}" http://{base-url}/rest/api/2/issue/{issue-key}/attachments
      Rails.logger.debug "Wrote file #{fileloc}"
      command = %q[curl -D- -v -u #{ENV['JIRA_USER']}:#{ENV['JIRA_PASS']} -X POST -H "X-Atlassian-Token: nocheck" -F "file=@#{fileloc}" #{ENV['JIRA_API']}/rest/api/2/issue/#{self.jira_key}/attachments]
      result = %x(command)
    end

  end


  private

  def self.find_or_create_by_sfdcid(sfdcid,subject=nil)
    jarray = find_by_sfdcid(sfdcid)
    j = jarray.first
    if j.nil?
      j = self.create!(sfdcid,type='Media: New Business',subject )
    end
    j
  end

  def self.create!(sfdcid,type='Media: New Business',subject = "Test created #{Time.now.utc.to_s} by #{__FILE__}", parent_key = nil)
    jlc = Jiralicious::Issue.new
    jlc.fields.set_id("project", "11490") # this is the ICF project. Hardcoded :)
    jlc.fields.set_id("issuetype", Value::IssueType.jira_id(type)) # this is a campaign launch
    jlc.fields.set("summary", ENV['CALLOUT']+"#{subject}" )
    jlc.save
    jlc.fields.set("customfield_11862", sfdcid )
    jlc.save
    j = self.new(jlc)
    j
  end

end