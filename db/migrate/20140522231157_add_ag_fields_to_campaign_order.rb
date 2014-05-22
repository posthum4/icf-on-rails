class AddAgFieldsToCampaignOrder < ActiveRecord::Migration
  def change
    add_column :campaign_orders, :audience_requirements, :String,
    add_column :campaign_orders, :audience_hard_constraints, :String,
    add_column :campaign_orders, :audience_guarantee_age, :String,
    add_column :campaign_orders, :audience_guarantee_gender, :String,
    add_column :campaign_orders, :audience_guarantee_geo, :String,
    add_column :campaign_orders, :audience_guarantee_verification_vendor, :String
    add_column :campaign_orders, :viewability_optimization_goal, :float
  end
end
