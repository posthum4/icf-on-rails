module ViewModel
  class LineItem
    include ActionView::Helpers::NumberHelper

    attr_accessor :goal, :product, :media_channel

    def initialize(line_item)
      #@currency                    = CampaignOrder(line_item.campaign_order_id)
      @ordinal                     = line_item.ordinal.to_s
      @shortname                   = line_item.io_line_item.gsub("|","\")
      # TODO: 2014-04-05 add currency view on amount and pricing term
      @amount                      = ViewModel::Amount.new(line_item.budget).to_s
      @product                     = line_item.product
      @media_channel               = line_item.media_channel
      @impressions                 = number_with_delimiter(line_item.impressions, delimiter: "\u{2009}")
      @bonus_impressions           = number_with_delimiter(line_item.bonus_impressions, delimiter: "\u{2009}")
      @cost                        = ViewModel::Amount.new(line_item.price).to_s
      @pricing_term                = line_item.pricing_term
      @flight_instructions         = line_item.flight_instructions
      @add_on                      = line_item.add_on
      @goal                        = line_item.goal
      @secondary_optimization_goal = line_item.secondary_optimization_goal
      self
    end

    def to_s
      s ||= "|" + ( @ordinal           or "\u{2009}" )
      s <<  "|" + ( @shortname         or "\u{2009}" )
      s <<  "|" + ( @amount            or "\u{2009}" )
      s <<  "|" + ( @product           or "\u{2009}" )
      s <<  "|" + ( @media_channel     or "\u{2009}" )
      s <<  "|" + ( @impressions       or "\u{2009}" )
      s <<  "|" + ( @bonus_impressions or "\u{2009}" )
      s <<  "|" + ( @cost              or "\u{2009}" )
      s <<  "|" + ( @pricing_term      or "\u{2009}" )
      s <<  "|\n"
      s
    end

    def paid
      s ||= "|" + ( @ordinal + "/paid" or "\u{2009}" )
      s <<  "|" + ( @shortname         or "\u{2009}" )
      s <<  "|" + ( @amount            or "\u{2009}" )
      s <<  "|" + ( @product           or "\u{2009}" )
      s <<  "|" + ( @media_channel     or "\u{2009}" )
      s <<  "|" + ( @impressions       or "\u{2009}" )
      s <<  "|" + ( @cost              or "\u{2009}" )
      s <<  "|" + ( @pricing_term      or "\u{2009}" )
      s <<  "|\n"
      s
    end

    def bonus
      if @bonus_impressions == "0"
        s = ""
      else
        s ||= "|" + ( @ordinal + "/bonus" or "\u{2009}" )
        s <<  "|" + ( @shortname         or "\u{2009}" )
        s <<  "|" + "\u{2009}"
        s <<  "|" + ( @product           or "\u{2009}" )
        s <<  "|" + ( @media_channel     or "\u{2009}" )
        s <<  "|" + ( @bonus_impressions or "\u{2014}" )
        s <<  "|" + "\u{2009}"
        s <<  "|" + "\u{2009}"
        s <<  "|\n"
      end
      s
    end
  end
end
