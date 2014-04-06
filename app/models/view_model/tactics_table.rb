module ViewModel
  class TacticsTable

    def initialize(campaign_order)
      @campaign_order = campaign_order
      self.to_s
    end

    def to_s
      s = ''
      @campaign_order.line_items.each do |li|
        s << ViewModel::TacticsPanel.new(li).to_s
      end
      s
    end


  end
end