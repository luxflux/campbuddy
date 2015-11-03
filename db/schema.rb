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

ActiveRecord::Schema.define(version: 20151103194346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  create_table "camps", force: :cascade do |t|
    t.string   "name",                               null: false
    t.string   "subdomain",                          null: false
    t.string   "schema_name",                        null: false
    t.integer  "organization_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "hashtag"
    t.date     "starts"
    t.date     "ends"
    t.datetime "registration_opens"
    t.string   "welcome_text"
    t.boolean  "allow_sign_up",      default: false
    t.text     "welcome_mail"
    t.string   "reply_to"
  end

  add_index "camps", ["schema_name"], name: "index_camps_on_schema_name", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "identifier"
    t.integer  "order"
    t.boolean  "mandatory_events",             default: false
    t.boolean  "info_events",                  default: false
  end

  create_table "emergency_numbers", force: :cascade do |t|
    t.string   "name"
    t.string   "number"
    t.integer  "color"
    t.integer  "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "title",         limit: 255
    t.text     "description"
    t.string   "meeting_point", limit: 255
    t.datetime "starts"
    t.datetime "ends"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_attendees"
    t.integer  "category_id"
    t.string   "impression",    limit: 255
    t.boolean  "groups_only",               default: false
    t.string   "teaser"
    t.string   "youtube_url"
  end

  add_index "events", ["owner_id"], name: "index_events_on_owner_id", using: :btree

  create_table "group_attendances", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_attendances", ["event_id"], name: "index_group_attendances_on_event_id", using: :btree
  add_index "group_attendances", ["group_id"], name: "index_group_attendances_on_group_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "leader_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
  end

  add_index "groups", ["leader_id"], name: "index_groups_on_leader_id", using: :btree

  create_table "maps", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "map"
    t.integer  "order"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["user_id", "group_id"], name: "index_memberships_on_user_id_and_group_id", unique: true, using: :btree

  create_table "news", force: :cascade do |t|
    t.string   "message",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "visible_until"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "domain",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "firstname",          limit: 255
    t.string   "email",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128
    t.string   "avatar",             limit: 255
    t.string   "invitation_token",   limit: 255
    t.boolean  "guest",                          default: false
    t.integer  "organization_id"
    t.date     "birthday"
    t.string   "cellphone"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["organization_id"], name: "index_users_on_organization_id", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  add_foreign_key "users", "organizations"
end
