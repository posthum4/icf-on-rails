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
  factory :order do
    sfdcid "MyString"
    name "MyString"
    close_date "2014-03-10"
    amount "9.99"
    campaign_start_date "2014-03-10"
    vertical "MyString"
    account "MyString"
    agency "MyString"
    advertiser "MyString"
    stage_name "MyString"
    opportunity_owner "MyString"
    opp_type_new "MyString"
    account_manager "MyString"
    sales_region "MyString"
    last_modified_date "2014-03-10 18:30:23"
    brand "MyString"
    campaign_end_date "2014-03-10"
    campaign_objectives "MyText"
    primary_audience_am "MyString"
    secondary_audience_am "MyString"
    hard_constraints_am "MyString"
    is_secondary_audience_a_hard_constraint "MyString"
    rfp_special_client_requests "MyString"
    special_client_requirements "MyString"
    special_notes "MyText"
    brand_safety_vendor "MyString"
    type_of_service "MyString"
    brand_safety_restrictions "MyString"
    who_is_paying_for_brand_safety "MyString"
    client_vendor_pre_existing_relations "MyString"
    who_will_implement_adchoices_icon "MyString"
    brand_safety_notes "MyString"
    who_will_wrap_the_tags "MyString"
    io_case "MyString"
    viewability "MyString"
    viewability_metrics "MyString"
    who_is_paying_for_viewability "MyString"
    parent_order "MyString"
  end
end
