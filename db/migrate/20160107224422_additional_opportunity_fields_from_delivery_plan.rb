class AdditionalOpportunityFieldsFromDeliveryPlan < ActiveRecord::Migration
  def change
    add_column :campaign_orders, :add_on_products, :string
    add_column :campaign_orders, :add_on_product_details, :text
    add_column :campaign_orders, :who_is_paying_for_perf_monitor_survey, :string
    add_column :campaign_orders, :performance_monitoring_survey_vendor, :string
    add_column :campaign_orders, :other_vendor, :string
    add_column :campaign_orders, :mobile_sdk_vendor, :string
    add_column :campaign_orders, :who_is_paying_for_rich_media_display, :string
    add_column :campaign_orders, :who_is_rich_media_vendor_display, :string
    add_column :campaign_orders, :who_is_paying_for_rich_media_mobile, :string
    add_column :campaign_orders, :who_is_rich_media_vendor_mobile, :string
  end
end
