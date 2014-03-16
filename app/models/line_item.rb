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

class LineItem < ActiveRecord::Base
  belongs_to :order
end
