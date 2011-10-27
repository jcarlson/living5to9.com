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

ActiveRecord::Schema.define(:version => 20111027221854) do

  create_table "permalinks", :force => true do |t|
    t.string   "slug"
    t.integer  "content_id"
    t.string   "content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.date     "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "image_exif"
    t.text     "image_iptc"
    t.string   "image_uid"
    t.string   "image_ext"
    t.string   "image_name"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "publish_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",     :default => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "content_id"
    t.string   "content_type"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "term"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
