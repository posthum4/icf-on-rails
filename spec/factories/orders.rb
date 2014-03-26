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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :enterprise_dsp do
    sfdcid "0068000000oAoSg"
    name "Enterprise: DSP"
  end
  factory :channel_booking do
    sfdcid "0068000000iVbIV"
    name "Channel: Booking"
  end
end
