# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employee do
    name "MyString"
    username "MyString"
    function "MyString"
    salesforce_user ""
    jira_user ""
  end
end
