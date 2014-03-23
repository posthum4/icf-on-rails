# == Schema Information
#
# Table name: orders
#
#  sfdcid                                  :string(15)
#  name                                    :string(255)
#  close_date                              :date
#  amount                                  :decimal(, )
#  campaign_start_date                     :date
#  vertical                                :string(255)
#  account                                 :string(255)
#  agency                                  :string(255)
#  advertiser                              :string(255)
#  stage_name                              :string(255)
#  opportunity_owner                       :string(255)
#  opp_type_new                            :string(255)
#  account_manager                         :string(255)
#  sales_region                            :string(255)
#  last_modified_date                      :datetime
#  brand                                   :string(255)
#  campaign_end_date                       :date
#  campaign_objectives                     :text
#  primary_audience_am                     :string(255)
#  secondary_audience_am                   :string(255)
#  hard_constraints_am                     :string(255)
#  is_secondary_audience_a_hard_constraint :string(255)
#  rfp_special_client_requests             :string(255)
#  special_client_requirements             :string(255)
#  special_notes                           :text
#  brand_safety_vendor                     :string(255)
#  type_of_service                         :string(255)
#  brand_safety_restrictions               :string(255)
#  who_is_paying_for_brand_safety          :string(255)
#  client_vendor_pre_existing_relations    :string(255)
#  who_will_implement_adchoices_icon       :string(255)
#  brand_safety_notes                      :string(255)
#  who_will_wrap_the_tags                  :string(255)
#  io_case                                 :string(255)
#  viewability                             :string(255)
#  viewability_metrics                     :string(255)
#  who_is_paying_for_viewability           :string(255)
#  parent_order                            :string(255)
#  created_at                              :datetime
#  updated_at                              :datetime
#

require 'spec_helper'

describe Order do
  before do
    @o = Array[]
    oppts = [
      '0068000000oAoSg', # 0 @o Enterprise: DSP
      '0068000000iVbIV', # 1 @p Channel: Booking
      '0068000000m9tPS', # 2 @q Media: Renewal
      '0068000000lOV8c', # 3 @r Media: New Business
      '0068000000nO334', # 4 @s Media: Budget Change
      '239872349872349'  # 5 Non-existant
    ]
    oppts.each { |o| @o << Order.find_or_create_by(sfdcid: o) }
  end

  context 'when opportunity exists' do

    #   context 'when New Business' do
    #     describe '#type' do
    #       it 'is a NewBusiness instance' do
    #         expect(@o[3]).to be_an_instance_of(NewBusiness)
    #       end
    #       it 'is not an Order instance' do
    #         expect(@o[3]).not_to be_an_instance_of(Order)
    #       end
    #     end
    #   end

    #   context 'when Renewal' do
    #     describe '#type' do
    #       it 'is a Renewal instance' do
    #         expect(@o[2]).to be_an_instance_of(Renewal)
    #       end
    #       it 'is not an Order instance' do
    #         expect(@o[2]).not_to be_an_instance_of(Order)
    #       end
    #     end
    #   end

    # context 'when JIRA exists' do
    #   describe '#jira_key' do
    #     it 'returns the JIRA key' do
    #       expect(@o[0].jira_key).to match('ICF-3214')
    #     end
    #   end
    # end

    # # context 'when JIRA does not exist', focus: true do
    # context 'when JIRA does not exist' do
    #   describe '#jira_key' do
    #     it 'returns nil' do
    #       expect(@o[1].jira_key).to be_nil
    #     end
    #   end

    #   describe '#in_jira?' do
    #     it 'returns false' do
    #       expect(@o[1].in_jira?).to be_false
    #     end
    #   end

    #   describe '#find_or_create_jira' do
    #     let(:p) { Order.find('0068000000iVbIV') }
    #     it 'returns a JIRA' do
    #       expect(@o[1].find_or_create_jira.jira_key).to match(/(ICF-\d{4})/)
    #     end
    #   end

    # end

    # context 'when simple Line Items' do
    #   describe '#line_items' do
    #     it 'has line items', focus: true do
    #       expect(@o[3].line_items).not_to be_nil
    #     end
    #     it 'has paid line items' do
    #       expect(@o[3].line_items['paid']).not_to be_nil
    #     end
    #     it 'has bonus line items' do
    #       expect(@o[3].line_items['bonus']).not_to be_nil
    #     end
    #     it 'has 1 paid line item' do
    #       expect(@o[3].line_items['paid']).to have(1).things
    #     end
    #     it 'has 1 bonus line item' do
    #       expect(@o[3].line_items['bonus']).to have(1).things
    #     end
    #   end

    # end

    describe '::find_or_create_by_(sfdcid)' do
      it 'is valid' do
        expect(@o[0].name).to match('Bloomingdale')
      end
      it 'is an Order type' do
        expect(@o[0]).to be_kind_of(Order)
      end
    end

    # describe '#sfdcid' do
    #   it 'matches an opportunity ID syntax' do
    #     expect(@o[0].sfdcid).to match(/(0068000000\w{5,})/)
    #   end
    #   it 'returns the same opportunity ID' do
    #     expect(@o[0].sfdcid).to eql('0068000000oAoSg')
    #   end
    # end
  end

  context 'when opportunity does not exist' do
    describe '::find' do
      it 'is nil' do
        expect(@o[5]).to be_nil
      end
    end
  end
end
