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

ActiveRecord::Schema.define(:version => 20130521073435) do

  create_table "books", :force => true do |t|
    t.integer "captain_id"
    t.string  "recipient_fb_id"
    t.string  "occasion"
    t.date    "event_date"
    t.date    "reminder_1"
    t.date    "reminder_2"
    t.date    "final_reminder"
    t.date    "contribution_deadline"
    t.string  "book_size"
    t.string  "invite_message_subject"
    t.string  "invite_message_body"
    t.string  "sharing_preference"
    t.string  "name"
  end

  create_table "friends", :force => true do |t|
    t.integer "user_id"
    t.string  "uid"
    t.string  "name"
  end

  create_table "pages", :force => true do |t|
    t.integer "book_id"
    t.integer "user_id"
    t.string  "layout"
    t.string  "background_color"
    t.string  "background_image_url"
    t.integer "position"
  end

  create_table "photos", :force => true do |t|
    t.integer "user_id"
    t.integer "book_id"
    t.integer "page_id"
    t.integer "position"
    t.string  "source_url"
    t.string  "caption"
    t.date    "fb_created_date"
    t.string  "fb_object_id"
    t.boolean "is_picked"
  end

  create_table "roles", :force => true do |t|
    t.integer "book_id"
    t.integer "user_id"
    t.string  "role_type"
  end

  create_table "texts", :force => true do |t|
    t.integer "user_id"
    t.integer "book_id"
    t.integer "page_id"
    t.string  "message"
    t.integer "position"
    t.string  "font_size"
    t.string  "font_type"
    t.string  "font_color"
  end

  create_table "users", :force => true do |t|
    t.string  "email"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "password"
    t.string  "billing_address"
    t.string  "billing_city"
    t.string  "billing_state"
    t.string  "billing_phone"
    t.string  "shipping_address"
    t.string  "shipping_city"
    t.string  "shipping_state"
    t.string  "shipping_phone"
    t.string  "access_token"
    t.string  "facebook_id"
    t.boolean "is_activated"
    t.string  "full_name"
    t.string  "provider"
    t.string  "uid"
  end

end
