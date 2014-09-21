class AddSplitNotesToCampaignOrder < ActiveRecord::Migration
  def change
    add_column :campaign_orders, :split_notes, :string
  end
end
