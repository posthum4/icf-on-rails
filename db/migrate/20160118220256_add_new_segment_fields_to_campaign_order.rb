class AddNewSegmentFieldsToCampaignOrder < ActiveRecord::Migration
  def change
    add_column :campaign_orders, :advertiser_segment, :string
    add_column :campaign_orders, :primary_account_segment, :string
  end
end
