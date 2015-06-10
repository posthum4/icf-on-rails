class AddRawFieldsToCampaignOrder < ActiveRecord::Migration
  def change
    add_column :campaign_orders, :opportunity_transcript, :text
    add_column :campaign_orders, :delivery_plan_transcript, :text
  end
end
