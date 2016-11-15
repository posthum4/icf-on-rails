class AddServiceModelToCampaignOrder < ActiveRecord::Migration
  def change
    add_column :campaign_orders, :service_level, :string
  end
end
