module Service
  class CampaignOrderImporter

    attr_accessor :sfdcid, :opportunity, :jira, :description

    def initialize(sfdcid)
      @sfdcid = sfdcid
      @opportunity = SalesForce::Opportunity.find(@sfdcid)
      @fields = Value::Field.new
      @description = ViewModel::Description.new(@sfdcid).to_s
    end

    def import
      return false unless @opportunity
      return false unless @sfdcid
      description(f)
    end

    private




  end
end
