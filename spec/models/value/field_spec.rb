require 'spec_helper'

describe Value::Field do
  before do
    @f = Value::Field.new
  end


  describe '#for_campaign_order' do
    it 'is enumerable' do
      expect(@f.for_campaign_order).to respond_to(:each)
    end

    it 'contains rows' do
      expect(@f.for_campaign_order.first).to be_a_kind_of(CSV::Row)
    end
  end

end
