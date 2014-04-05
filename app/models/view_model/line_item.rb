module ViewModel
  class LineItem

    def initialize(line_item)
      @ordinal                     = line_item.ordinal
      @add_on                      = line_item.add_on
      @amount                      = line_item.amount
      @bonus_impressions           = line_item.bonus_impressions
      @cost                        = line_item.cost
      @flight_instructions         = line_item.flight_instructions
      @goal                        = line_item.goal
      @impressions                 = line_item.impressions
      @io_line_item                = line_item.io_line_item
      @media_channel               = line_item.media_channel
      @pricing_term                = line_item.pricing_term
      @product                     = line_item.product
      @secondary_optimization_goal = line_item.secondary_optimization_goal
    end

    def to_s
      s ||= "|#{@ordinal} "
      s <<  "|#{@} "
      s <<  "|#{@} "
      s <<  "|#{@} "
      s <<  "|#{@} "
      s <<  "|#{@} "
      s <<  "|#{@} "
      s <<  "|#{@} "
      s <<  "|#{@} "
      s <<  "|#{@} "
      s <<  "|#{@} "
      s <<  "|#{@} "
      s
    end

    def header_s
    end
  end
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