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

ActiveRecord::Schema.define(version: 20160330175236) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amenities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["order_id"], name: "index_comments_on_order_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.integer  "property_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "images", ["property_id"], name: "index_images_on_property_id", using: :btree

  create_table "mailing_list_emails", force: :cascade do |t|
    t.string "email"
  end

  create_table "order_products", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_products", ["order_id"], name: "index_order_products_on_order_id", using: :btree
  add_index "order_products", ["product_id"], name: "index_order_products_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.string   "description"
    t.integer  "category_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "sale",               default: false
    t.integer  "sale_price"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "inactive",           default: false
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "properties", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "price"
    t.string   "street"
    t.string   "unit"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "bedrooms"
    t.integer  "bathrooms"
    t.integer  "sleeps"
    t.integer  "user_id"
    t.integer  "property_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",           default: "pending"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "properties", ["property_type_id"], name: "index_properties_on_property_type_id", using: :btree
  add_index "properties", ["user_id"], name: "index_properties_on_user_id", using: :btree

  create_table "property_amenities", force: :cascade do |t|
    t.integer "property_id"
    t.integer "amenity_id"
  end

  add_index "property_amenities", ["amenity_id"], name: "index_property_amenities_on_amenity_id", using: :btree
  add_index "property_amenities", ["property_id"], name: "index_property_amenities_on_property_id", using: :btree

  create_table "property_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservation_nights", force: :cascade do |t|
    t.integer "reservation_id"
    t.date    "night"
  end

  add_index "reservation_nights", ["reservation_id"], name: "index_reservation_nights_on_reservation_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.string   "street"
    t.string   "unit"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "status",      default: "paid"
    t.string   "fullname"
    t.string   "card_token"
    t.integer  "order_total"
    t.integer  "property_id"
    t.date     "checkin"
    t.date     "checkout"
  end

  add_index "reservations", ["property_id"], name: "index_reservations_on_property_id", using: :btree
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "role",            default: 0
    t.string   "fullname"
    t.string   "slug"
    t.string   "status",          default: "active"
  end

  add_foreign_key "comments", "reservations", column: "order_id"
  add_foreign_key "images", "properties"
  add_foreign_key "order_products", "products"
  add_foreign_key "order_products", "reservations", column: "order_id"
  add_foreign_key "products", "categories"
  add_foreign_key "properties", "property_types"
  add_foreign_key "properties", "users"
  add_foreign_key "property_amenities", "amenities"
  add_foreign_key "property_amenities", "properties"
  add_foreign_key "reservation_nights", "reservations"
  add_foreign_key "reservations", "properties"
  add_foreign_key "reservations", "users"
end
