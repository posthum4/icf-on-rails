class OrderImporter

  def initialize(order,sfdcid)
    @order = order
    @opportunity = Opportunity.find_by(Id: sfdcid)
  end

  def import
    return false unless @order
    return false unless @opportunity
    Field.present_in_order.each |f| do
      @order[f.name_in_order] = @opportunity[f.name_in_oppt]
    end

  end

end
