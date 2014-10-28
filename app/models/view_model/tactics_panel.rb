module ViewModel
  class TacticsPanel

    include ActionView::Helpers::NumberHelper

    def initialize(line_item)
      @li       = line_item
    end

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
#      s << "\n| _set_model_1_here_ | _set_segment_1_here_\n"
#      [2,3,4].each{|x| s << "_set_segment_#{x.to_s}_here_\n" }
#      s << "_set_segment_n_here_ | 100% |"
      s << "\n| _set_model_1_here_ | _set_segment_1_here_ | 1000% |"

      s << "\n| _set_model_n_here_ | _set_segment_n_here_ | 0% |"
      s << "\n{panel}"
    end

    def bonus
      if @li.fractional_bonus == 0
        s = ""
      else
        s = "\n{panel:title=BONUS Line Item \##{@li.ordinal}. #{@li.io_line_item}|titleBGColor=#AAAABB|bgColor=#E0EEFF}"
        s << "\n\n||BONUS Line Item||Value||"
        s << "\n|Fractional Bonus:| #{number_to_percentage(@li.fractional_bonus)}|"
        s << "\n|Min CPM:| #{ENV['MINCPM']}|"
        s << "\n|Max CPM:| #{ENV['MAXCPM']}|"
        s << "\n\n||BONUS Tactic || Segment/Target || Budget Allocation ||"
#      s << "\n| _set_model_1_here_ | _set_segment_1_here_\n"
#      [2,3,4].each{|x| s << "_set_segment_#{x.to_s}_here_\n" }
#      s << "_set_segment_n_here_ | 100% |"
        s << "\n| _set_model_1_here_ | _set_segment_1_here_ | 1000% |"

        s << "\n| _set_model_n_here_ | _set_segment_n_here_ | 0% |"
        s << "\n{panel}"
      end
      s
    end
  end
end
