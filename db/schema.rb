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

ActiveRecord::Schema.define(version: 20151208221916) do

  create_table "line_items", force: :cascade do |t|
    t.integer  "quantity"
    t.string   "product_name"
    t.float    "net_total"
    t.float    "gross_total"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "product_id"
    t.integer  "order_id"
  end

  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id"
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id"

  create_table "orders", force: :cascade do |t|
    t.string   "customer_name"
    t.float    "net_total"
    t.float    "gross_total"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.float    "net_price"
    t.float    "vat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
