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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130511195704) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.string   "label"
    t.text     "content",    :limit => 255
    t.text     "summary",    :limit => 255
    t.boolean  "publish"
    t.boolean  "frontpage"
    t.string   "menu"
    t.integer  "rank",                      :default => 5
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "author"
    t.string   "image"
    t.string   "gallery"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "article"
    t.text     "date",            :limit => 255
    t.string   "start_time"
    t.string   "start_date"
    t.string   "end_date"
    t.boolean  "sun",                            :default => false
    t.boolean  "mon",                            :default => false
    t.boolean  "tue",                            :default => false
    t.boolean  "wed",                            :default => false
    t.boolean  "thu",                            :default => false
    t.boolean  "fri",                            :default => false
    t.boolean  "sat",                            :default => false
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.text     "cancelled_dates"
    t.string   "abbr"
  end

  create_table "galleries", :force => true do |t|
    t.string   "name"
    t.text     "photos"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  create_table "photos", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "custom_size"
  end

  create_table "site_infos", :force => true do |t|
    t.string   "title"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "weekly"
    t.string   "menubar"
    t.string   "bannerpic"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.boolean  "author"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
