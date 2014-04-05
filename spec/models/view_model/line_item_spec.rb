require 'spec_helper'

describe 'ViewModel::LineItem' do
  before do
    @livm = ViewModel::LineItem.new(LineItem.find(80))
  end
  describe '#to_s' do
    expect(@livm.to_s).to match(/\|\d\|.*/)
  end
end
