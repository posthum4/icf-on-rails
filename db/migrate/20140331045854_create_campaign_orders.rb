class CreateCampaignOrders < ActiveRecord::Migration
  def change
    create_table :campaign_orders do |t|
      t.string :sfdcid
      t.string :name
      t.string :jira_key

      t.timestamps
    end
  end
end
