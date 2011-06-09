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

ActiveRecord::Schema.define(:version => 20110608125015) do

  create_table "brands", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_categories", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carryings", :force => true do |t|
    t.integer  "merchant_id", :null => false
    t.integer  "brand_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merchants", :force => true do |t|
    t.string   "name",                 :null => false
    t.string   "address",              :null => false
    t.string   "city",                 :null => false
    t.string   "postcode",             :null => false
    t.string   "email"
    t.string   "phone"
    t.string   "hours"
    t.text     "description"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "business_category_id", :null => false
  end

  create_table "photos", :force => true do |t|
    t.integer  "merchant_id"
    t.string   "data_file_name"
    t.string   "string"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id",                    :null => false
    t.string   "gender",        :limit => 1
    t.date     "date_of_birth"
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "postcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "gender",                 :limit => 1
    t.date     "date_of_birth"
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "postcode"
    t.string   "type",                                                  :null => false
    t.integer  "merchant_id"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
