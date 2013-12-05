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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131205125036) do

  create_table "categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.boolean  "is_parent"
    t.integer  "status"
    t.integer  "sort_order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "contact"
    t.string   "contact_tel"
    t.string   "address"
    t.integer  "register_capital"
    t.string   "main_biz"
    t.string   "legal_person"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "goods_exts", :force => true do |t|
    t.integer  "goods_prop_id"
    t.string   "prop_value"
    t.integer  "order_goods_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "goods_exts", ["goods_prop_id"], :name => "index_goods_exts_on_goods_prop_id"
  add_index "goods_exts", ["order_goods_id"], :name => "index_goods_exts_on_order_goods_id"

  create_table "goods_prop_values", :force => true do |t|
    t.integer  "category_id"
    t.integer  "goods_prop_id"
    t.string   "prop_value"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "goods_prop_values", ["category_id"], :name => "index_goods_prop_values_on_category_id"
  add_index "goods_prop_values", ["goods_prop_id"], :name => "index_goods_prop_values_on_goods_prop_id"

  create_table "goods_props", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.integer  "status"
    t.integer  "sort_order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "order_goods", :force => true do |t|
    t.integer  "order_id"
    t.integer  "quantity"
    t.decimal  "price",      :precision => 8, :scale => 2
    t.string   "name"
    t.string   "category"
    t.string   "model"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "order_goods", ["order_id"], :name => "index_order_goods_on_order_id"

  create_table "order_price_histories", :force => true do |t|
    t.integer  "order_id"
    t.datetime "bid_time"
    t.decimal  "price",      :precision => 8, :scale => 2
    t.integer  "seller_id"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "order_price_histories", ["order_id"], :name => "index_order_price_histories_on_order_id"

  create_table "orders", :force => true do |t|
    t.datetime "create_time"
    t.decimal  "price",       :precision => 8, :scale => 2
    t.integer  "price_type"
    t.integer  "status"
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.decimal  "deal_price",  :precision => 8, :scale => 2
    t.datetime "deadline"
    t.datetime "deal_date"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "nickname"
    t.integer  "company_id"
    t.string   "user_type"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "users", ["company_id"], :name => "index_users_on_company_id"

end