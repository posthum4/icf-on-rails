module ViewModel
  class LineItemTable

    def initialize(campaign_order)
      @campaign_order   = campaign_order
      @line_items       = @campaign_order.line_items
      @stagename       = @campaign_order.stagename
      @header           = '||#||Line Item||Budget||Product||Channel||Imp||Price||Term||'
      @panelfooter      = '{panel}'
      set_reliability
    end

    def set_reliability
      case @stagename
      when 'Closed Won'
        @warning    = "Imported @#{@stagename}: Low chance of inconsistency with IO. In case of doubt, IO is king."
        @colors     = %w/ #99CC66 #CCFF99 /
      when 'Pending IO Review'
        @warning    = "Imported @#{@stagename}: Medium chance inconsistency with IO. Please double check."
        @colors     = %w/ #FFFF00 #FFFF99 /
      else
        @warning    = "Imported @#{@stagename}: HIGH CHANCE of inconsistency with IO - Please TRIPLE CHECK."
        @colors     = %w/ #FF6600 #FF9966 /
      end
    end

    def to_s
      s ||= '{panel:title=' + "#{@warning}|titleBGColor=#{@colors[0]}|bgColor=#{@colors[1]}" + '}'
      s << "\n"
      s << core_table
      s << "\n"
      s << @panelfooter
      s
    end

    def core_table
      Rails.logger.level = Logger::DEBUG
      s ||= @header
      s << "\n"
      @line_items.each do |li|
        s << ViewModel::LineItem.new(li).paid
        s << ViewModel::LineItem.new(li).bonus
      end
      s
      #Rails.logger.debug "\n\n #{s.to_yaml}\n s = #{s.class}\n#{__FILE__}:#{__LINE__}"
    end

  end

end
