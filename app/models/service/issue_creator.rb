module Service
  class IssueCreator

    attr_accessor :sfdcid, :campaign_order, :jira, :fields, :description

    def initialize(sfdcid)
      @sfdcid = sfdcid
      @co = CampaignOrder.find_or_create_by(sfdcid: sfdcid)
      @opportunity = SalesForce::Opportunity.find(@sfdcid)
      @jira = find_or_create_jira_by_sfdcid
      @fields = Value::Field.new
      @description = ViewModel::Description.new(@sfdcid).to_s
      import_from_sfdc
      @jira
    end

    def find_or_create_jira_by_sfdcid
      return false unless @co
      return false unless @sfdcid
      j = Jira::Issue.find_or_create_by_sfdcid(@sfdcid)
      @co.jira_key = j.key
      @co.save
      j
    end

    def jira_key
      @jira.key
    end

    def import_from_sfdc
      matched_fields
    end

    def matched_fields
      @fields.jira_direct.each do |a|
        sfdc_field, jira_field = a
        @jira.set_field(jira_field, @opportunity[sfdc_field].to_s)
      end
      @jira.set_field("description", @description)
      @jira.save
    end


  end

end
