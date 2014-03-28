module Jira
  class Issue

    attr_accessor :key, :summary, :assignee, :reporter, :sfdcid

    def initialize(j)
      @key        = j.jira_key
      @summary    = j.summary
      @assignee   = j['fields']['assignee']['name']
      @reporter   = j['fields']['reporter']['name']
      @updated_at = j.updated.to_datetime
      @created_at = j.created.to_datetime
      @sfdcid     = j.customfield_11862
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

    def self.find_or_create_by_sfdcid(sfdcid)
      j = find_by_sfdcid(sfdcid).first
      if j.nil?
        j = create!(sfdcid)
      end
      j
    end

    private
    def self.create!(sfdcid,type='launch', summary = "Test created #{Time.now.utc.to_s} by #{__FILE__}", parent_key = nil)
      j = Jiralicious::Issue.new
      j.fields.set_id("project", "11490") # this is the ICF project. Hardcoded :)
      j.fields.set_id("issuetype", Value::IssueType.jira_id(type)) # this is a campaign launch
      j.fields.set("summary", ENV['CALLOUT']+summary )
      j.save
      j.fields.set("customfield_11862", sfdcid )
      j.save
    end

  end
end
