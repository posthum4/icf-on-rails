# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170111175410) do

  create_table "attachments", force: :cascade do |t|
    t.string   "sfdcid",            limit: 255
    t.string   "name",              limit: 255
    t.string   "content_type",      limit: 255
    t.binary   "body",              limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campaign_order_id", limit: 4
  end

  add_index "attachments", ["campaign_order_id"], name: "index_attachments_on_campaign_order_id", using: :btree

  create_table "campaign_orders", force: :cascade do |t|
    t.string   "sfdcid",                                  limit: 255
    t.string   "name",                                    limit: 255
    t.string   "jira_key",                                limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "amount",                                                precision: 10, scale: 2
    t.string   "amount_currency",                         limit: 255
    t.date     "campaign_start_date"
    t.date     "campaign_end_date"
    t.string   "opp_type_new",                            limit: 255
    t.string   "original_opportunity",                    limit: 255
    t.string   "stagename",                               limit: 255
    t.date     "closedate"
    t.string   "io_case",                                 limit: 255
    t.datetime "lastmodifieddate"
    t.string   "brand",                                   limit: 255
    t.string   "vertical",                                limit: 255
    t.string   "advertiser",                              limit: 255
    t.string   "account",                                 limit: 255
    t.string   "agency",                                  limit: 255
    t.string   "sales_region",                            limit: 255
    t.string   "account_executive",                       limit: 255
    t.string   "account_manager",                         limit: 255
    t.text     "campaign_objectives",                     limit: 65535
    t.string   "primary_audience_am",                     limit: 255
    t.string   "secondary_audience_am",                   limit: 255
    t.string   "hard_constraints_am",                     limit: 255
    t.string   "is_secondary_audience_a_hard_constraint", limit: 255
    t.text     "rfp_special_client_requests",             limit: 65535
    t.text     "special_client_requirements",             limit: 65535
    t.string   "special_notes",                           limit: 255
    t.string   "brand_safety_vendor",                     limit: 255
    t.string   "type_of_service",                         limit: 255
    t.string   "brand_safety_restrictions",               limit: 255
    t.string   "who_is_paying_for_brand_safety",          limit: 255
    t.string   "client_vendor_pre_existing_relations",    limit: 255
    t.string   "who_will_implement_adchoices_icon",       limit: 255
    t.text     "brand_safety_notes",                      limit: 65535
    t.string   "who_will_wrap_the_tags",                  limit: 255
    t.string   "viewability",                             limit: 255
    t.string   "viewability_metrics",                     limit: 255
    t.string   "who_is_paying_for_viewability",           limit: 255
    t.integer  "budget_cents",                            limit: 4
    t.string   "budget_currency",                         limit: 255,                            default: "USD", null: false
    t.string   "messageid",                               limit: 255
    t.text     "result",                                  limit: 65535
    t.string   "insights_package",                        limit: 255
    t.string   "offline_sales_impact",                    limit: 255
    t.string   "viewability_vendor",                      limit: 255
    t.string   "suppl_add_on_products",                   limit: 255
    t.string   "rm_ad_serving_fees",                      limit: 255
    t.string   "who_is_paying_for_rm_ad_serving_fees",    limit: 255
    t.string   "who_is_rm_vendor",                        limit: 255
    t.string   "account_executive_2",                     limit: 255
    t.string   "audience_requirements",                   limit: 255
    t.string   "audience_hard_constraints",               limit: 255
    t.string   "audience_guarantee_age",                  limit: 255
    t.string   "audience_guarantee_gender",               limit: 255
    t.string   "audience_guarantee_geo",                  limit: 255
    t.string   "audience_guarantee_verification_vendor",  limit: 255
    t.float    "viewability_optimization_goal",           limit: 24
    t.string   "customer_tier",                           limit: 255
    t.string   "split_notes",                             limit: 255
    t.text     "opportunity_transcript",                  limit: 65535
    t.text     "delivery_plan_transcript",                limit: 65535
    t.string   "sf_account_id",                           limit: 255
    t.datetime "scheduled_date"
    t.string   "add_on_products",                         limit: 255
    t.text     "add_on_product_details",                  limit: 65535
    t.string   "who_is_paying_for_perf_monitor_survey",   limit: 255
    t.string   "performance_monitoring_survey_vendor",    limit: 255
    t.string   "other_vendor",                            limit: 255
    t.string   "mobile_sdk_vendor",                       limit: 255
    t.string   "who_is_paying_for_rich_media_display",    limit: 255
    t.string   "who_is_rich_media_vendor_display",        limit: 255
    t.string   "who_is_paying_for_rich_media_mobile",     limit: 255
    t.string   "who_is_rich_media_vendor_mobile",         limit: 255
    t.string   "service_level",                           limit: 255
    t.string   "advertiser_segment",                      limit: 255
    t.string   "primary_account_segment",                 limit: 255
    t.string   "delivery_plan_id",                        limit: 255
    t.string   "emp_package",                             limit: 255
    t.string   "emp_packages",                            limit: 255
  end

  create_table "employees", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "username",           limit: 255
    t.string   "function",           limit: 255
    t.integer  "salesforce_user_id", limit: 4
    t.integer  "jira_user_id",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", force: :cascade do |t|
    t.string   "add_on",                      limit: 255
    t.decimal  "amount",                                    precision: 10, scale: 2
    t.integer  "bonus_impressions",           limit: 4
    t.decimal  "cost",                                      precision: 10, scale: 2
    t.text     "flight_instructions",         limit: 65535
    t.string   "goal",                        limit: 255
    t.integer  "impressions",                 limit: 8
    t.string   "io_line_item",                limit: 255
    t.string   "media_channel",               limit: 255
    t.string   "pricing_term",                limit: 255
    t.string   "product",                     limit: 255
    t.string   "secondary_optimization_goal", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campaign_order_id",           limit: 4
    t.integer  "ordinal",                     limit: 4
    t.integer  "budget_cents",                limit: 4
    t.string   "budget_currency",             limit: 255,                            default: "USD", null: false
    t.integer  "price_cents",                 limit: 4
    t.string   "shortname",                   limit: 255
    t.string   "ad_format",                   limit: 255
    t.string   "inventory_type",              limit: 255
  end

  add_index "line_items", ["campaign_order_id"], name: "index_line_items_on_campaign_order_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
