class AddEmpPackageToCampaignOrders < ActiveRecord::Migration
  def change
    add_column :campaign_orders, :emp_packages, :string
  end
end
