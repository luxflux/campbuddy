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

ActiveRecord::Schema.define(version: 20140726102747) do

  create_table "attendances", force: true do |t|
    t.integer  "user_id"
    t.integer  "workshop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendances", ["user_id", "workshop_id"], name: "index_attendances_on_user_id_and_workshop_id", unique: true

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "leader_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["leader_id"], name: "index_groups_on_leader_id"

  create_table "jobs", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "starts"
    t.datetime "ends"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jobs", ["group_id"], name: "index_jobs_on_group_id"

  create_table "memberships", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["user_id", "group_id"], name: "index_memberships_on_user_id_and_group_id", unique: true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "firstname"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "workshops", force: true do |t|
    t.integer  "owner_id"
    t.datetime "starts"
    t.datetime "ends"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workshops", ["owner_id"], name: "index_workshops_on_owner_id"

end
