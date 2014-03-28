class RemoveOtherDetailsFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :opp_type_new, :string
    remove_column :orders, :account_manager, :string
    remove_column :orders, :sales_region, :string
    remove_column :orders, :last_modified_date, :datetime
    remove_column :orders, :brand, :string
    remove_column :orders, :campaign_end_date, :date
    remove_column :orders, :campaign_objectives, :text
    remove_column :orders, :primary_audience_am, :string
    remove_column :orders, :secondary_audience_am, :string
    remove_column :orders, :hard_constraints_am, :string
    remove_column :orders, :is_secondary_audience_a_hard_constraint, :string
    remove_column :orders, :rfp_special_client_requests, :string
    remove_column :orders, :special_client_requirements, :string
    remove_column :orders, :special_notes, :text
    remove_column :orders, :brand_safety_vendor, :string
    remove_column :orders, :type_of_service, :string
    remove_column :orders, :brand_safety_restrictions, :string
    remove_column :orders, :who_is_paying_for_brand_safety, :string
    remove_column :orders, :client_vendor_pre_existing_relations, :string
    remove_column :orders, :who_will_implement_adchoices_icon, :string
    remove_column :orders, :brand_safety_notes, :string
    remove_column :orders, :who_will_wrap_the_tags, :string
    remove_column :orders, :io_case, :string
    remove_column :orders, :viewability, :string
    remove_column :orders, :viewability_metrics, :string
    remove_column :orders, :who_is_paying_for_viewability, :string
  end
end
