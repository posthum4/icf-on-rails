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

ActiveRecord::Schema.define(version: 20140311013308) do

  create_table "line_items", force: true do |t|
    t.string   "add_on"
    t.decimal  "amount"
    t.integer  "bonus_impressions"
    t.decimal  "cost"
    t.text     "flight_instructions"
    t.string   "goal"
    t.integer  "impressions"
    t.string   "io_line_item"
    t.string   "media_channel"
    t.string   "pricing_term"
    t.string   "product"
    t.string   "secondary_optimization_goal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.string   "sfdcid"
    t.string   "name"
    t.date     "close_date"
    t.decimal  "amount"
    t.date     "campaign_start_date"
    t.string   "vertical"
    t.string   "account"
    t.string   "agency"
    t.string   "advertiser"
    t.string   "stage_name"
    t.string   "opportunity_owner"
    t.string   "opp_type_new"
    t.string   "account_manager"
    t.string   "sales_region"
    t.datetime "last_modified_date"
    t.string   "brand"
    t.date     "campaign_end_date"
    t.text     "campaign_objectives"
    t.string   "primary_audience_am"
    t.string   "secondary_audience_am"
    t.string   "hard_constraints_am"
    t.string   "is_secondary_audience_a_hard_constraint"
    t.string   "rfp_special_client_requests"
    t.string   "special_client_requirements"
    t.text     "special_notes"
    t.string   "brand_safety_vendor"
    t.string   "type_of_service"
    t.string   "brand_safety_restrictions"
    t.string   "who_is_paying_for_brand_safety"
    t.string   "client_vendor_pre_existing_relations"
    t.string   "who_will_implement_adchoices_icon"
    t.string   "brand_safety_notes"
    t.string   "who_will_wrap_the_tags"
    t.string   "io_case"
    t.string   "viewability"
    t.string   "viewability_metrics"
    t.string   "who_is_paying_for_viewability"
    t.string   "parent_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
