module Value
  class CommonLineItemSubstring

    def initialize(campaign_order)
      @campaign_order = campaign_order
    end

    def shorter_name
      cutout = line_item_names.longest_common_substr
      li[1..-1].each do |a|
        unless a.nil?
          unless cutout.nil? || a['Line Item'] == cutout || cutout.length < 5
            a['Line Item'].gsub!(cutout,'..').gsub!(/\.{2,}/,'..')
          end
        end
      end
    end

  end

  def longest_common_substr
    shortest = self.min_by &:length
    maxlen = shortest.length
    maxlen.downto(0) do |len|
      0.upto(maxlen - len) do |start|
        substr = shortest[start,len]
        return substr if ( self.all?{|str| str.include? substr } )
      end
    end
  end

end
