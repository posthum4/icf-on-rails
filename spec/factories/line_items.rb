# == Schema Information
#
# Table name: line_items
#
#  id                          :integer          not null, primary key
#  add_on                      :string(255)
#  amount                      :decimal(, )
#  bonus_impressions           :integer
#  cost                        :decimal(, )
#  flight_instructions         :text
#  goal                        :string(255)
#  impressions                 :integer
#  io_line_item                :string(255)
#  media_channel               :string(255)
#  pricing_term                :string(255)
#  product                     :string(255)
#  secondary_optimization_goal :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#

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
