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

ActiveRecord::Schema.define(version: 2021_10_26_235855) do

  create_table "menu_items", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 10
    t.text "description"
    t.integer "options"
    t.boolean "vegan"
    t.boolean "vegetarian"
    t.boolean "gluten_free"
    t.integer "menu_item_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "menu_items_menus", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.bigint "menu_id", null: false
    t.bigint "menu_item_id", null: false
  end

  create_table "menu_items_orders", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "menu_item_id", null: false
  end

  create_table "menus", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.integer "restaurant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", charset: "utf8mb4", force: :cascade do |t|
    t.date "date"
    t.text "notes"
    t.decimal "total", precision: 10
    t.integer "restaurant_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "restaurants", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
