# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_08_170131) do
  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "uf_id", null: false
    t.index ["uf_id"], name: "index_cities_on_uf_id"
  end

  create_table "deliveries", force: :cascade do |t|
    t.integer "travel_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_deliveries_on_product_id"
    t.index ["travel_id"], name: "index_deliveries_on_travel_id"
  end

  create_table "product_types", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "weight"
    t.string "dimension"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "travels", force: :cascade do |t|
    t.date "destination_date"
    t.date "date_of_origin"
    t.date "expected_date"
    t.integer "origin_city_id"
    t.integer "destination_city_id"
    t.integer "truck_driver_id"
    t.integer "product_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destination_city_id"], name: "index_travels_on_destination_city_id"
    t.index ["origin_city_id"], name: "index_travels_on_origin_city_id"
    t.index ["product_type_id"], name: "index_travels_on_product_type_id"
    t.index ["truck_driver_id"], name: "index_travels_on_truck_driver_id"
  end

  create_table "truck_drivers", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ufs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cities", "ufs"
  add_foreign_key "deliveries", "products"
  add_foreign_key "deliveries", "travels"
  add_foreign_key "travels", "cities", column: "destination_city_id"
  add_foreign_key "travels", "cities", column: "origin_city_id"
  add_foreign_key "travels", "product_types"
  add_foreign_key "travels", "truck_drivers"
end
