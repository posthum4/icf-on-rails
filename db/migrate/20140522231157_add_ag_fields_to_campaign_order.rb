class AddAgFieldsToCampaignOrder < ActiveRecord::Migration
  def change
    add_column :campaign_orders, :audience_requirements, :string
    add_column :campaign_orders, :audience_hard_constraints, :string
    add_column :campaign_orders, :audience_guarantee_age, :string
    add_column :campaign_orders, :audience_guarantee_gender, :string
    add_column :campaign_orders, :audience_guarantee_geo, :string
    add_column :campaign_orders, :audience_guarantee_verification_vendor, :string
    add_column :campaign_orders, :viewability_optimization_goal, :float
  end
end
