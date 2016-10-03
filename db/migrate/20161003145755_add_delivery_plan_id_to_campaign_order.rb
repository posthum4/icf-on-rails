class AddDeliveryPlanIdToCampaignOrder < ActiveRecord::Migration
  def change
    add_column :campaign_orders, :delivery_plan_id, :string
  end
end