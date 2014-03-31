module Service
  class CampaignOrderImporter

    def initialize(campaign_order,sfdcid)
      @co = campaign_order
      @opportunity = Opportunity.find_by(Id: sfdcid)
      import
    end

    def import
      return false unless @co
      return false unless @opportunity
      # Field.present_in_order.each do |f|
      #   @order[f.name_in_order] = @opportunity[f.name_in_oppt]
      # end

    end

  end
end
