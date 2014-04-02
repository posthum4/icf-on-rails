require 'spec_helper'

describe CampaignOrder do

  before do
    @campaign_order = FactoryGirl.create :campaign_order
    #@a = CampaignOrder.find_by(sfdcid: '0068000000oAoSg')
    #   #VCR.use_cassette 'model/campaign_order' do
    #   @o = Array[]
    #   oppts = [
    #     '0068000000oAoSg', # 0 @o Enterprise: DSP
    #     '0068000000iVbIV', # 1 @p Channel: Booking
    #     '0068000000m9tPS', # 2 @q Media: Renewal
    #     '0068000000lOV8c', # 3 @r Media: New Business
    #     '0068000000nO334'  # 4 @s Media: Budget Change
    #   ]
    #   oppts.each do |o|
    #     @o << CampaignOrder.find_or_create_by(sfdcid: o)
    #   end
    #   puts @o.inspect
    #   #      @p = CampaignOrder.find_by(jira_key: 'ICF-3214')
    #   #end
  end

  describe '.find_or_create_by_(sfdcid)' do
    it 'is an Order type' do
      expect(@campaign_order).to be_kind_of(CampaignOrder)
    end
  end

  describe '#sfdcid' do
    it 'matches an opportunity ID syntax' do
      expect(@campaign_order.sfdcid).to match(/(0068000000\w{5,})/)
    end
    it 'returns the same opportunity ID' do
      expect(@campaign_order.sfdcid).to eql('0068000000oAoSg')
    end
  end
  
end
