class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :sfdcid
      t.string :name
      t.date :close_date
      t.decimal :amount
      t.date :campaign_start_date
      t.string :vertical
      t.string :account
      t.string :agency
      t.string :advertiser
      t.string :stage_name
      t.string :opportunity_owner
      t.string :opp_type_new
      t.string :account_manager
      t.string :sales_region
      t.datetime :last_modified_date
      t.string :brand
      t.date :campaign_end_date
      t.text :campaign_objectives
      t.string :primary_audience_am
      t.string :secondary_audience_am
      t.string :hard_constraints_am
      t.string :is_secondary_audience_a_hard_constraint
      t.string :rfp_special_client_requests
      t.string :special_client_requirements
      t.text :special_notes
      t.string :brand_safety_vendor
      t.string :type_of_service
      t.string :brand_safety_restrictions
      t.string :who_is_paying_for_brand_safety
      t.string :client_vendor_pre_existing_relations
      t.string :who_will_implement_adchoices_icon
      t.string :brand_safety_notes
      t.string :who_will_wrap_the_tags
      t.string :io_case
      t.string :viewability
      t.string :viewability_metrics
      t.string :who_is_paying_for_viewability
      t.string :parent_order

      t.timestamps
    end
  end
end
