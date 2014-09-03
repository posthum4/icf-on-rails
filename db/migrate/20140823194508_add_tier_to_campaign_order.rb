class AddTierToCampaignOrder < ActiveRecord::Migration
  def change
    add_column :campaign_orders, :customer_tier, :string
  end
end
