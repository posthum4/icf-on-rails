module Service
  class OpportunityImporter

    attr_accessor :sfdcid

    def initialize(campaign_order)
      @campaign_order = campaign_order
      @opportunity    = SalesForce::Opportunity.find(@campaign_order.sfdcid)
      @fields         = Value::Field.new.from_oppt_to_co
      binding.pry
      import_all
    end

    def import_all
      @fields.each do |a|
        oppt_field,co_field = a
        binding.pry
        @campaign_order.instance_variable_set '@' + co_field, @opportunity[oppt_field]
        puts @campaign_order
      end
    end

    def format
    end

  end
end
