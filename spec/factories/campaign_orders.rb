# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :campaign_order do
    sfdcid "0068000000oAoSg"
    name "Bloomingdale"
    jira_key "ICF-3214"
  end
  factory :channel_booking do
    sfdcid "0068000000iVbIV"
  end
  factory :media_renewal do
    sfdcid "0068000000m9tPS"
  end
  factory :media_new_business do
    sfdcid "0068000000lOV8c"
  end
  factory :media_budget_change do
    sfdcid "0068000000nO334"
  end
end
