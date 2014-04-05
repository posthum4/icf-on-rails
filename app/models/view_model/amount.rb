
module ViewModel
  class Amount

    def initialize(num, isocode)
      @m = Money.new(num, isocode)
    end

  end

end
