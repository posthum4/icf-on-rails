class ChangeCampaignOrderStringsToText < ActiveRecord::Migration
  def up
    change_column :campaign_orders, :campaign_objectives, :text
    change_column :campaign_orders, :rfp_special_client_requests, :text
    change_column :campaign_orders, :special_client_requirements, :text
  end
  def down
    change_column :campaign_orders, :campaign_objectives, :string
    change_column :campaign_orders, :rfp_special_client_requests, :string
    change_column :campaign_orders, :special_client_requirements, :string
  end
end
