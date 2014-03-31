require 'spec_helper'

describe Value::Field do
  before do
    @f = Value::Field.new
  end


  describe '#for_order' do
    it 'is enumerable' do
      expect(@f).to respond_to(:each)
    end
  end

end
