module ViewModel
  class LineItem
    include ActionView::Helpers::NumberHelper

    attr_accessor :goal, :product, :media_channel

    def initialize(line_item)
      #@currency                    = CampaignOrder(line_item.campaign_order_id)
      @ordinal                     = line_item.ordinal.to_s
      @io_line_item                = line_item.io_line_item
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
    end

    def to_s
      s ||= "|" + ( @ordinal           or "\u{2009}" )
      s <<  "|" + ( @io_line_item      or "\u{2009}" )
      s <<  "|" + ( @amount            or "\u{2009}" )
      s <<  "|" + ( @product           or "\u{2009}" )
      s <<  "|" + ( @media_channel     or "\u{2009}" )
      s <<  "|" + ( @impressions       or "\u{2009}" )
      s <<  "|" + ( @bonus_impressions or "\u{2009}" )
      s <<  "|" + ( @cost              or "\u{2009}" )
      s <<  "|" + ( @pricing_term      or "\u{2009}" )
      s <<  "|"
      s
    end

=begin
{panel:title=Line Items from SalesForce. Please verify with IO for consistency.|titleBGColor=#99CC66|bgColor=#CCFF99}
||#||Line Item||Budget||Product||Channel||Imp||Imp bonus||Price||Term||
|1|Audience Booster|£8 500
$13 600|Audience Booster|Display Banner|6 666 667|666 667|£1.50
$2.40|CPM|
|+| __ | __ | __ | __ | __ | __ | __ | __ |
{panel}
=end

    def header_s
    end
  end
end
