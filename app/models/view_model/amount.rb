module ViewModel

  class Amount

    def initialize(money_obj)
      @obj          = money_obj
      @currency     = @obj.currency_as_string
      @local_amt    = @obj.amount
    end

    def to_s
      if @currency == 'USD'
        @obj.format(:thousands_separator => "\u{2009}")
      else
        @usd_obj = @obj.as_us_dollar
        case @currency
        when 'CAD', 'AUD'
          s = @obj.format(:symbol => false, :with_currency => true, :thousands_separator => "\u{2009}") + "\n"
          s << @usd_obj.format(:symbol => false, :with_currency => true, :thousands_separator => "\u{2009}")
        else
          s = @obj.format(:thousands_separator => "\u{2009}") + "\n"
          s << @usd_obj.format(:thousands_separator => "\u{2009}")
        end
      end
    end

  end
end
