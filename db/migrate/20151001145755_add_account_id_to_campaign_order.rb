class AddAccountIdToCampaignOrder < ActiveRecord::Migration
  def change
  	add_column :campaign_orders, :sf_account_id, :string
  end
end
