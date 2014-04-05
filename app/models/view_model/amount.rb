module ViewModel
  class Amount

    attr_accessor :local_amount, :local_isocode, :obj, :in_usd
    require 'csv'

    @@rates_set = false

    def self.set_rates
      rates = CSV::read("#{Rails.root}/db/currencies.csv", headers: true)
      arr = rates.values_at('ISO','FY14')
      arr.each do |r|
        Money.add_rate(r[0].strip,'USD', r[1].strip.to_f)
      end
      @@rates_set = true
    end

    def initialize(num, isocode)
      ViewModel::Amount.set_rates unless @@rates_set
      @local_amount  = 100 * num
      @local_isocode = isocode
      @obj           = Money.new(local_amount, local_isocode)
      @in_usd        = @obj.exchange_to("USD")
    end

    def to_s

    end

  end

end
