class LineItem < ActiveRecord::Base
  belongs_to :campaign_order
end
