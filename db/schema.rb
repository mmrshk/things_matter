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

ActiveRecord::Schema.define(version: 2020_12_17_185408) do

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

  create_table "attachments", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "attachable_id"
    t.string "attachable_type"
    t.string "type"
    t.string "file"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attachable_id", "attachable_type"], name: "index_attachments_on_attachable_id_and_attachable_type", unique: true
    t.index ["type"], name: "index_attachments_on_type"
  end

  create_table "note_areas", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name", default: ""
    t.uuid "user_account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position"
    t.date "deleted_date"
    t.boolean "deleted", default: false
    t.index ["user_account_id"], name: "index_note_areas_on_user_account_id"
  end

  create_table "note_images", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "note_id"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["note_id"], name: "index_note_images_on_note_id"
  end

  create_table "note_projects", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name", default: ""
    t.date "deadline"
    t.uuid "note_area_id"
    t.uuid "user_account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position"
    t.boolean "deleted", default: false
    t.date "deleted_date"
    t.index ["note_area_id"], name: "index_note_projects_on_note_area_id"
    t.index ["user_account_id"], name: "index_note_projects_on_user_account_id"
  end

  create_table "notes", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name", default: ""
    t.text "description"
    t.boolean "default", default: false
    t.uuid "note_project_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position"
    t.boolean "deleted", default: false
    t.date "deleted_date"
    t.uuid "user_account_id"
    t.index ["note_project_id"], name: "index_notes_on_note_project_id"
    t.index ["user_account_id"], name: "index_notes_on_user_account_id"
  end

  create_table "schema_extensions", force: :cascade do |t|
  end

  create_table "task_areas", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name", default: ""
    t.uuid "user_account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position"
    t.date "deleted_date"
    t.boolean "deleted", default: false
    t.index ["user_account_id"], name: "index_task_areas_on_user_account_id"
  end

  create_table "task_images", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "task_id"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["task_id"], name: "index_task_images_on_task_id"
  end

  create_table "task_projects", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name", default: ""
    t.date "deadline"
    t.uuid "task_area_id"
    t.uuid "user_account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position"
    t.boolean "deleted", default: false
    t.date "deleted_date"
    t.index ["task_area_id"], name: "index_task_projects_on_task_area_id"
    t.index ["user_account_id"], name: "index_task_projects_on_user_account_id"
  end

  create_table "tasks", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name", default: ""
    t.text "description"
    t.boolean "done", default: false
    t.boolean "deleted", default: false
    t.date "deadline"
    t.date "to_do_day"
    t.uuid "task_project_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position"
    t.date "deleted_date"
    t.uuid "user_account_id"
    t.index ["task_project_id"], name: "index_tasks_on_task_project_id"
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
  add_foreign_key "note_areas", "user_accounts"
  add_foreign_key "note_images", "notes"
  add_foreign_key "note_projects", "note_areas"
  add_foreign_key "note_projects", "user_accounts"
  add_foreign_key "notes", "note_projects"
  add_foreign_key "task_areas", "user_accounts"
  add_foreign_key "task_images", "tasks"
  add_foreign_key "task_projects", "task_areas"
  add_foreign_key "task_projects", "user_accounts"
  add_foreign_key "tasks", "task_projects"
  add_foreign_key "user_profiles", "user_accounts"
end
