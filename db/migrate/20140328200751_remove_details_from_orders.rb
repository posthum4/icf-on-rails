class RemoveDetailsFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :close_date, :date
    remove_column :orders, :amount, :decimal
    remove_column :orders, :campaign_start_date, :date
    remove_column :orders, :vertical, :string
    remove_column :orders, :account, :string
    remove_column :orders, :agency, :string
    remove_column :orders, :advertiser, :string
    remove_column :orders, :stage_name, :string
    remove_column :orders, :opportunity_owner, :string
  end
end
