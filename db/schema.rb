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

ActiveRecord::Schema[7.0].define(version: 2022_10_05_005635) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "unaccent"
  enable_extension "uuid-ossp"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "models", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "brand_type", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_type"], name: "index_models_on_brand_type"
    t.index ["created_by_id"], name: "index_models_on_created_by_id"
    t.index ["deleted_at"], name: "index_models_on_deleted_at"
    t.index ["name"], name: "index_models_on_name"
    t.index ["updated_by_id"], name: "index_models_on_updated_by_id"
  end

  create_table "optionals", force: :cascade do |t|
    t.string "name", limit: 50
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_optionals_on_created_by_id"
    t.index ["deleted_at"], name: "index_optionals_on_deleted_at"
    t.index ["updated_by_id"], name: "index_optionals_on_updated_by_id"
    t.index ["uuid"], name: "index_optionals_on_uuid"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", limit: 90, null: false
    t.text "description", null: false
    t.integer "brand_type", null: false
    t.datetime "model_year", null: false
    t.integer "gearbox_type"
    t.integer "fuel_type"
    t.integer "steering_type"
    t.boolean "with_gnv"
    t.boolean "vehicle_type"
    t.integer "mileage"
    t.integer "door_type"
    t.integer "end_plate_type"
    t.integer "color_type"
    t.boolean "accept_exchange"
    t.string "cep"
    t.integer "category_type"
    t.float "price"
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
    t.bigint "model_id"
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_type"], name: "index_posts_on_brand_type"
    t.index ["created_by_id"], name: "index_posts_on_created_by_id"
    t.index ["deleted_at"], name: "index_posts_on_deleted_at"
    t.index ["description"], name: "index_posts_on_description"
    t.index ["model_id"], name: "index_posts_on_model_id"
    t.index ["model_year"], name: "index_posts_on_model_year"
    t.index ["title"], name: "index_posts_on_title"
    t.index ["updated_by_id"], name: "index_posts_on_updated_by_id"
    t.index ["uuid"], name: "index_posts_on_uuid"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at", precision: nil
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.string "nickname"
    t.string "email", limit: 60
    t.date "birthday"
    t.string "cellphone"
    t.string "cpf"
    t.boolean "is_admin", default: false, null: false
    t.boolean "is_blocked", default: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.boolean "active", default: true, null: false
    t.json "tokens"
    t.datetime "deleted_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "users_timeout", default: false
    t.integer "timeout_in"
    t.index ["active"], name: "index_users_on_active"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["uuid"], name: "index_users_on_uuid"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "models", "users", column: "created_by_id"
  add_foreign_key "models", "users", column: "updated_by_id"
  add_foreign_key "optionals", "users", column: "created_by_id"
  add_foreign_key "optionals", "users", column: "updated_by_id"
  add_foreign_key "posts", "models"
  add_foreign_key "posts", "users", column: "created_by_id"
  add_foreign_key "posts", "users", column: "updated_by_id"
end
