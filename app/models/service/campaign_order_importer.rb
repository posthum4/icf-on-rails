module Service
  class CampaignOrderImporter

    attr_accessor :sfdcid, :opportunity, :jira, :description, :fields

    def initialize(sfdcid,jira=nil)
      @sfdcid = sfdcid
      @opportunity = SalesForce::Opportunity.find(@sfdcid)
      @fields = Value::Field.new
      @description = ViewModel::Description.new(@sfdcid).to_s
      @jira = jira
    end

    def import
      return false unless @opportunity
      return false unless @sfdcid

    end

    def matched_fields
      @fields.jira_direct.each do |a|
        sfdc_field, jira_field = a
        @jira.set(jira_field, @opportunity[sfdc_field].to_s)
      end
      @jira.set("description", @description)
      @jira.save
    end

  end
end
