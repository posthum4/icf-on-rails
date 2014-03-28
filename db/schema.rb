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

ActiveRecord::Schema.define(version: 20140328201152) do

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
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.string   "sfdcid",       limit: 15
    t.string   "name"
    t.string   "parent_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "jira_key"
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
