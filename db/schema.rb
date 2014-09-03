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

ActiveRecord::Schema.define(version: 20140823194508) do

  create_table "attachments", force: true do |t|
    t.string   "sfdcid"
    t.string   "name"
    t.string   "content_type"
    t.binary   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campaign_order_id"
  end

  add_index "attachments", ["campaign_order_id"], name: "index_attachments_on_campaign_order_id", using: :btree

  create_table "campaign_orders", force: true do |t|
    t.string   "sfdcid"
    t.string   "name"
    t.string   "jira_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "amount",                                  precision: 10, scale: 2
    t.string   "amount_currency"
    t.date     "campaign_start_date"
    t.date     "campaign_end_date"
    t.string   "opp_type_new"
    t.string   "original_opportunity"
    t.string   "stagename"
    t.date     "closedate"
    t.string   "io_case"
    t.datetime "lastmodifieddate"
    t.string   "brand"
    t.string   "vertical"
    t.string   "advertiser"
    t.string   "account"
    t.string   "agency"
    t.string   "sales_region"
    t.string   "account_executive"
    t.string   "account_manager"
    t.text     "campaign_objectives"
    t.string   "primary_audience_am"
    t.string   "secondary_audience_am"
    t.string   "hard_constraints_am"
    t.string   "is_secondary_audience_a_hard_constraint"
    t.text     "rfp_special_client_requests"
    t.text     "special_client_requirements"
    t.string   "special_notes"
    t.string   "brand_safety_vendor"
    t.string   "type_of_service"
    t.string   "brand_safety_restrictions"
    t.string   "who_is_paying_for_brand_safety"
    t.string   "client_vendor_pre_existing_relations"
    t.string   "who_will_implement_adchoices_icon"
    t.text     "brand_safety_notes"
    t.string   "who_will_wrap_the_tags"
    t.string   "viewability"
    t.string   "viewability_metrics"
    t.string   "who_is_paying_for_viewability"
    t.integer  "budget_cents"
    t.string   "budget_currency",                                                  default: "USD", null: false
    t.string   "messageid"
    t.text     "result"
    t.string   "insights_package"
    t.string   "offline_sales_impact"
    t.string   "viewability_vendor"
    t.string   "suppl_add_on_products"
    t.string   "rm_ad_serving_fees"
    t.string   "who_is_paying_for_rm_ad_serving_fees"
    t.string   "who_is_rm_vendor"
    t.string   "account_executive_2"
    t.string   "audience_requirements"
    t.string   "audience_hard_constraints"
    t.string   "audience_guarantee_age"
    t.string   "audience_guarantee_gender"
    t.string   "audience_guarantee_geo"
    t.string   "audience_guarantee_verification_vendor"
    t.float    "viewability_optimization_goal"
    t.string   "customer_tier"
  end

  create_table "employees", force: true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "function"
    t.integer  "salesforce_user_id"
    t.integer  "jira_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", force: true do |t|
    t.string   "add_on"
    t.decimal  "amount",                                precision: 10, scale: 2
    t.integer  "bonus_impressions"
    t.decimal  "cost",                                  precision: 10, scale: 2
    t.text     "flight_instructions"
    t.string   "goal"
    t.integer  "impressions",                 limit: 8
    t.string   "io_line_item"
    t.string   "media_channel"
    t.string   "pricing_term"
    t.string   "product"
    t.string   "secondary_optimization_goal"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campaign_order_id"
    t.integer  "ordinal"
    t.integer  "budget_cents"
    t.string   "budget_currency",                                                default: "USD", null: false
    t.integer  "price_cents"
    t.string   "shortname"
  end

  add_index "line_items", ["campaign_order_id"], name: "index_line_items_on_campaign_order_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
