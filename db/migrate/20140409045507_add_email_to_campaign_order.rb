class AddEmailToCampaignOrder < ActiveRecord::Migration
  def change
    add_column :campaign_orders, :messageid, :string
    add_column :campaign_orders, :result, :text
  end
end
