# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :line_item do
    add_on "MyString"
    amount "9.99"
    bonus_impressions 1
    cost "9.99"
    flight_instructions "MyText"
    goal "MyString"
    impressions 1
    io_line_item "MyString"
    media_channel "MyString"
    pricing_term "MyString"
    product "MyString"
    secondary_optimization_goal "MyString"
  end
end
