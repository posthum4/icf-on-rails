# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :campaign_order do
    sfdcid "MyString"
    name "MyString"
    jira_key "MyString"
  end
end
