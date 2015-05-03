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

ActiveRecord::Schema.define(version: 20150503230204) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_logs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "ip_address"
    t.string   "user_id"
    t.text     "url"
    t.string   "action"
    t.text     "parameters"
  end

  create_table "branches", force: :cascade do |t|
    t.string   "branch_cd"
    t.string   "branch_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "branches", ["branch_cd"], name: "index_branches_on_branch_cd", using: :btree

  create_table "proposals", force: :cascade do |t|
    t.string   "branch_cd"
    t.string   "user_id"
    t.string   "proposal_date"
    t.string   "section_name1"
    t.string   "mail"
    t.string   "tel"
    t.string   "proposal_type"
    t.string   "project_type_a"
    t.string   "project_type_b"
    t.string   "project_type_c"
    t.string   "project_type_d"
    t.string   "project_type_e"
    t.string   "project_type_f"
    t.text     "proposal_title"
    t.text     "now_problem"
    t.text     "proposal_detail"
    t.text     "effect"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "section_name2"
    t.integer  "lock_version",    default: 0
  end

  add_index "proposals", ["branch_cd"], name: "index_proposals_on_branch_cd", using: :btree
  add_index "proposals", ["proposal_date"], name: "index_proposals_on_proposal_date", using: :btree
  add_index "proposals", ["user_id"], name: "index_proposals_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "user_id"
    t.string   "user_password"
    t.string   "user_name"
    t.string   "branch_cd"
    t.string   "section_name1"
    t.string   "mail"
    t.string   "tel"
    t.string   "role"
    t.string   "delete_flag"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "section_name2"
  end

  add_index "users", ["user_id"], name: "index_users_on_user_id", using: :btree

end
