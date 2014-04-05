require "spec_helper"

describe ViewModel::Amount do

  before do
    @a = ViewModel::Amount.new(1000,'EUR')
  end

  describe '#to_s' do
    it 'prints the currency symbol' do
      expect(@a.to_s).to match (/€.*/)
    end
  end

end
