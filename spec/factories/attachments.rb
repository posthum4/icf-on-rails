# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    sfdcid "MyString"
    name "MyString"
    content_type "MyString"
    body ""
  end
end
