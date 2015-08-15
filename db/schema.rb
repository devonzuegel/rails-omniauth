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

ActiveRecord::Schema.define(version: 20_150_814_234_359) do
  create_table 'accounts', force: :cascade do |t|
    t.string 'theme',        default: 'light'
    t.boolean 'public_posts', default: false
    t.integer 'user_id'
    t.datetime 'created_at',                     null: false
    t.datetime 'updated_at',                     null: false
    t.integer 'timezone'
  end

  add_index 'accounts', ['user_id'], name: 'index_accounts_on_user_id'

  create_table 'entries', force: :cascade do |t|
    t.string 'title'
    t.text 'body'
    t.datetime 'created_at',                 null: false
    t.datetime 'updated_at',                 null: false
    t.integer 'user_id'
    t.boolean 'public',     default: false
    t.integer 'visitor_id'
  end

  add_index 'entries', ['user_id'], name: 'index_entries_on_user_id'
  add_index 'entries', ['visitor_id'], name: 'index_entries_on_visitor_id'

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'provider'
    t.string 'uid'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
    t.string 'email'
    t.string 'first_name'
    t.string 'middle_name'
    t.string 'last_name'
    t.string 'image'
    t.string 'gender'
    t.string 'api_key'
  end

  create_table 'visitors', force: :cascade do |t|
    t.string 'ip_address'
    t.integer 'user_id'
    t.integer 'view_count', default: 0
    t.datetime 'created_at',             null: false
    t.datetime 'updated_at',             null: false
  end

  add_index 'visitors', ['user_id'], name: 'index_visitors_on_user_id'
end
