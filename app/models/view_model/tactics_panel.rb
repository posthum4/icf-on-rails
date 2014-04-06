module ViewModel
  class TacticsPanel

    include ActionView::Helpers::NumberHelper

    def initialize(line_item)
      @li       = line_item
    end

=begin
{panel:title=LI #1. ..BARRIE|titleBGColor=#0099FF|bgColor=#CCEEFF}
*Optimization Goal 1:* CTR
*Optimization Goal 2:*  

*Flight Instructions:* Target BARRIE only.  Bill line item separately.
*Margin* >'61%', <'90%'
*Regulus Target:* _SET_TARGET_HERE_

||Test table||Value||
||Header|Value|
||Header|Value|

||Tactic || Segment || Initial Budget || Frac bonus ||
| _SET_MODEL_HERE_ | _SET_SEGMENT_1_HERE_
_SET_SEGMENT_2_HERE_
_SET_SEGMENT_3_HERE_
_SET_SEGMENT_4_HERE_
_SET_SEGMENT_5_HERE_
_SET_SEGMENT_6_HERE_
_SET_SEGMENT_7_HERE_
_SET_SEGMENT_8_HERE_
_SET_SEGMENT_9_HERE_ | 100% | 4.762% |
=end

=begin
t = t+<<-ENDOFHEADERS
{panel:title=LI \##{@li.#']}. #{@li.Line Item'] }|titleBGColor=#0099FF|bgColor=#CCEEFF}
*Optimization Goal 1:* #{@li.Goal 1']}
*Optimization Goal 2:* #{@li.Goal 2']}

*Flight Instructions:* #{@li.Flight Instructions']}
*Margin* >#{MINMARGIN}, <#{MAXMARGIN}
*Regulus Target:* _SET_TARGET_HERE_
||Tactic || Segment || Initial Budget || Frac bonus ||
ENDOFHEADERS

t << "| _SET_MODEL_HERE_ | _SET_SEGMENT_1_HERE_\n"
[2,3,4].each{|x| t << "_SET_SEGMENT_#{x.to_s}_HERE_\n" }
t << "_SET_SEGMENT_N_HERE_ | 100% | #{@li.Frac bonus']} |"
t << "\n\r{panel}"
=end

    def to_s
      t = ''
      t << paid
      t << bonus if @li.bonus_impressions
      t
    end

    def paid
      s = "\n{panel:title=PAID Line Item \##{@li.ordinal}. #{@li.io_line_item}|titleBGColor=#0099FF|bgColor=#CCEEFF}"
      s << "\n||PAID Line Item||Value||"
      s << "\n|Main Client Goal:| #{@li.goal} _include_numerical_target_here_ |"
      s << "\n|(Secondary Client Goal):| #{@li.secondary_optimization_goal} _include_numerical_target_here_ |" if @li.secondary_optimization_goal
      s << "\n|Min Margin:| #{ENV['MINMARGIN']}|"
      s << "\n|Max Margin:| #{ENV['MAXMARGIN']}|"
      s << "\n|Regulus Target:| _set_target_here_ |"
      s << "\n|Flight Instructions:| #{@li.flight_instructions.gsub("\r\n",' / ')}|" if @li.flight_instructions
      s << "\n\n||PAID Tactic || Segment || Budget Allocation"
      s << "\n| _set_model_1_here_ | _set_segment_1_here_\n"
      [2,3,4].each{|x| s << "_set_segment_#{x.to_s}_here_\n" }
      s << "_set_segment_n_here_ | 100% |"
      s << "\n| _set_model_n_here_ | _set_segment_n_here_ | 0% |"
      s << "\n{panel}"
    end

    def bonus
      s = "\n{panel:title=BONUS Line Item \##{@li.ordinal}. #{@li.io_line_item}|titleBGColor=#AAAABB|bgColor=#E0EEFF}"
      s << "\n\n||BONUS Line Item||Value||"
      s << "\n|Fractional Bonus:| #{number_to_percentage(@li.fractional_bonus)}|"
      s << "\n|Min CPM:| #{ENV['MINCPM']}|"
      s << "\n|Max CPM:| #{ENV['MAXCPM']}|"
      s << "\n\n||BONUS Tactic || Segment/Target || Budget Allocation ||"
      s << "\n| _set_model_1_here_ | _set_segment_1_here_\n"
      [2,3,4].each{|x| s << "_set_segment_#{x.to_s}_here_\n" }
      s << "_set_segment_n_here_ | 100% |"
      s << "\n| _set_model_n_here_ | _set_segment_n_here_ | 0% |"
      s << "\n{panel}"
    end
  end
end
