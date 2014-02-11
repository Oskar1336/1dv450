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

ActiveRecord::Schema.define(version: 20140211210112) do

  create_table "api_keys", force: true do |t|
    t.integer  "Application_id"
    t.string   "key",            limit: 40, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applications", force: true do |t|
    t.string   "contact_mail",                null: false
    t.string   "application_name", limit: 50, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "licences", force: true do |t|
    t.string   "licence_type", limit: 40, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resource_types", force: true do |t|
    t.string   "resource_type", limit: 30, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", force: true do |t|
    t.integer  "ResourceType_id"
    t.integer  "User_id"
    t.integer  "Licence_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tag_resource_tables", force: true do |t|
    t.integer "Resource_id"
    t.integer "Tag_id"
  end

  create_table "tags", force: true do |t|
    t.string   "tag",        limit: 20, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "firstname",  limit: 40, null: false
    t.string   "lastname",   limit: 50, null: false
    t.string   "email",      limit: 40, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
