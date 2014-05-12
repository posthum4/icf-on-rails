class AddFieldsToCampaignOrder < ActiveRecord::Migration
  def change
    add_column :campaign_orders, :insights_package, :string
    add_column :campaign_orders, :offline_sales_impact, :string
    add_column :campaign_orders, :viewability_vendor, :string
    add_column :campaign_orders, :suppl_add_on_products, :string
    add_column :campaign_orders, :rm_ad_serving_fees, :string
    add_column :campaign_orders, :who_is_paying_for_rm_ad_serving_fees, :string
    add_column :campaign_orders, :who_is_rm_vendor, :string
    add_column :campaign_orders, :account_executive_2, :string
  end
end
