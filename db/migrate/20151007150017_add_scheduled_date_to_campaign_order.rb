class AddScheduledDateToCampaignOrder < ActiveRecord::Migration
  def change
  	add_column :campaign_orders, :scheduled_date, :datetime
  end
end
