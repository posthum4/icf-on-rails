module Service
  class CampaignOrderImporter

    attr_accessor :sfdcid, :opportunity, :jira, :description, :fields

    def initialize(sfdcid,jira=nil)
      @sfdcid = sfdcid
      @opportunity = SalesForce::Opportunity.find(@sfdcid)
      @description = ViewModel::Description.new(@sfdcid).to_s
      @fields = Value::Field.new
      @jira = jira
      self
    end

    def import
      return false unless @opportunity
      return false unless @sfdcid
      # TODO: 2014-04-01 add full import flow here
    end


  end
end
