# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_25_150331) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "areas", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name"
    t.string "type", null: false
    t.uuid "user_account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_account_id"], name: "index_areas_on_user_account_id"
  end

  create_table "notes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "default", default: false
    t.uuid "areas_id"
    t.uuid "projects_id"
    t.uuid "user_account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["areas_id"], name: "index_notes_on_areas_id"
    t.index ["projects_id"], name: "index_notes_on_projects_id"
    t.index ["user_account_id"], name: "index_notes_on_user_account_id"
  end

  create_table "projects", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.datetime "deadline"
    t.string "type", null: false
    t.uuid "area_id"
    t.uuid "user_account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["area_id"], name: "index_projects_on_area_id"
    t.index ["user_account_id"], name: "index_projects_on_user_account_id"
  end

  create_table "schema_extensions", force: :cascade do |t|
  end

  create_table "tasks", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "done", default: false
    t.boolean "deleted", default: false
    t.datetime "deadline"
    t.datetime "to_do_day"
    t.uuid "areas_id"
    t.uuid "projects_id"
    t.uuid "user_account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["areas_id"], name: "index_tasks_on_areas_id"
    t.index ["projects_id"], name: "index_tasks_on_projects_id"
    t.index ["user_account_id"], name: "index_tasks_on_user_account_id"
  end

  create_table "user_accounts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_user_accounts_on_email", unique: true
  end

  create_table "user_profiles", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "user_account_id", null: false
    t.index ["user_account_id"], name: "index_user_profiles_on_user_account_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "areas", "user_accounts"
  add_foreign_key "notes", "areas", column: "areas_id"
  add_foreign_key "notes", "projects", column: "projects_id"
  add_foreign_key "notes", "user_accounts"
  add_foreign_key "projects", "areas"
  add_foreign_key "projects", "user_accounts"
  add_foreign_key "tasks", "areas", column: "areas_id"
  add_foreign_key "tasks", "projects", column: "projects_id"
  add_foreign_key "tasks", "user_accounts"
  add_foreign_key "user_profiles", "user_accounts"
end
