module Value
  class CommonLineItemSubstring

    def initialize(campaign_order)
      @campaign_order = campaign_order
      @line_items     = @campaign_order.line_items
      #fail Exceptions::NoLineItemsFound, @campaign_order.sfdcid, @campaign_order.name if @line_items.empty? or @line_items.nil?
      return nil if @line_items.empty? or @line_items.nil?
      get_all_names
    end

    def get_all_names
      @all_names = []
      @line_items.each do |li|
        @all_names << li.io_line_item
      end
      @all_names
    end

    def to_s
      shortest = @all_names.min_by &:length
      maxlen = shortest.length
      maxlen.downto(0) do |len|
        0.upto(maxlen - len) do |start|
          substr = shortest[start,len]
          return substr if ( @all_names.all?{|str| str.include? substr } )
        end
      end
    end


    #     def shorter_name
    #       cutout = line_item_names.longest_common_substr
    #       li[1..-1].each do |a|
    #         unless a.nil?
    #           unless cutout.nil? || a['Line Item'] == cutout || cutout.length < 5
    #             a['Line Item'].gsub!(cutout,'..').gsub!(/\.{2,}/,'..')
    #           end
    #         end
    #       end
    #     end

    #   end

    # end

    # shortest = self.min_by &:length
  end

end
