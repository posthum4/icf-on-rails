module ViewModel
  class LineItem

    attr_accessor :goal, :product, :media_channel

    def initialize(line_item)
      #@currency                    = CampaignOrder(line_item.campaign_order_id)
      @ordinal                     = line_item.ordinal.to_s
      @add_on                      = line_item.add_on
      # TODO: 2014-04-05 add currency view on amount and pricing term
      @amount                      = line_item.amount.to_s
      @bonus_impressions           = line_item.bonus_impressions.to_s
      @cost                        = line_item.cost.to_s
      @flight_instructions         = line_item.flight_instructions
      @goal                        = line_item.goal
      @impressions                 = line_item.impressions.to_s
      @io_line_item                = line_item.io_line_item
      @media_channel               = line_item.media_channel
      @pricing_term                = line_item.pricing_term
      @product                     = line_item.product
      @secondary_optimization_goal = line_item.secondary_optimization_goal
    end

    def to_s
      s ||= "|" + ( @ordinal           or ' ' )
      s <<  "|" + ( @io_line_item      or ' ' )
      s <<  "|" + ( @amount            or ' ' )
      s <<  "|" + ( @product           or ' ' )
      s <<  "|" + ( @media_channel     or ' ' )
      s <<  "|" + ( @impressions       or ' ' )
      s <<  "|" + ( @bonus_impressions or ' ' )
      s <<  "|" + ( @cost              or ' ' )
      s <<  "|" + ( @pricing_term      or ' ' )
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
