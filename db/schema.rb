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

ActiveRecord::Schema.define(:version => 25) do

  create_table "categories", :force => true do |t|
    t.string   "rough_name"
    t.string   "display_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "boston_event_id"
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "start_time"
    t.string   "end_time"
    t.point    "location",           :limit => nil, :srid => 4326
  end

  add_index "events", ["location"], :name => "index_events_on_location", :spatial => true

  create_table "events_open_spaces", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "open_space_id"
  end

  add_index "events_open_spaces", ["event_id", "open_space_id"], :name => "index_events_open_spaces_on_event_id_and_open_space_id", :unique => true

  create_table "feature_taggings", :force => true do |t|
    t.integer  "feature_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feature_taggings", ["category_id", "feature_id"], :name => "index_feature_taggings_on_category_id_and_feature_id", :unique => true

  create_table "featured_links", :force => true do |t|
    t.integer  "open_space_id"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "features", :force => true do |t|
    t.integer  "open_space_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.point    "location",      :limit => nil, :srid => 4326
    t.string   "category"
    t.text     "directions"
  end

  add_index "features", ["location"], :name => "index_features_on_location", :spatial => true
  add_index "features", ["name"], :name => "index_features_on_name"

  create_table "features_open_spaces", :id => false, :force => true do |t|
    t.integer "feature_id"
    t.integer "open_space_id"
  end

  add_index "features_open_spaces", ["feature_id", "open_space_id"], :name => "index_features_open_spaces_on_feature_id_and_open_space_id", :unique => true

  create_table "features_regions", :id => false, :force => true do |t|
    t.integer "region_id"
    t.integer "feature_id"
  end

  add_index "features_regions", ["feature_id", "region_id"], :name => "index_features_regions_on_feature_id_and_region_id", :unique => true

  create_table "neighborhoods", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.polygon  "location",   :limit => nil, :srid => 4326
  end

  add_index "neighborhoods", ["location"], :name => "index_neighborhoods_on_location", :spatial => true
  add_index "neighborhoods", ["name"], :name => "index_neighborhoods_on_name"

  create_table "open_space_taggings", :force => true do |t|
    t.integer  "open_space_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "open_space_taggings", ["category_id", "open_space_id"], :name => "index_open_space_taggings_on_category_id_and_open_space_id", :unique => true

  create_table "open_spaces", :force => true do |t|
    t.string        "name"
    t.text          "description"
    t.integer       "dcr_park"
    t.text          "directions"
    t.datetime      "created_at"
    t.datetime      "updated_at"
    t.string        "photo_file_name"
    t.string        "photo_content_type"
    t.integer       "photo_file_size"
    t.datetime      "photo_updated_at"
    t.multi_polygon "location",           :limit => nil, :srid => 4326
    t.string        "ownership"
  end

  add_index "open_spaces", ["location"], :name => "index_open_spaces_on_location", :spatial => true
  add_index "open_spaces", ["name"], :name => "index_open_spaces_on_name"

  create_table "open_spaces_regions", :id => false, :force => true do |t|
    t.integer "region_id"
    t.integer "open_space_id"
  end

  add_index "open_spaces_regions", ["open_space_id", "region_id"], :name => "index_open_spaces_regions_on_open_space_id_and_region_id", :unique => true

  create_table "public_transport_stations", :force => true do |t|
    t.integer  "open_space_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.string        "name"
    t.datetime      "created_at"
    t.datetime      "updated_at"
    t.multi_polygon "location",           :limit => nil, :srid => 4326
    t.string        "photo_file_name"
    t.string        "photo_content_type"
    t.integer       "photo_file_size"
    t.datetime      "photo_updated_at"
  end

  add_index "regions", ["location"], :name => "index_regions_on_location", :spatial => true
  add_index "regions", ["name"], :name => "index_regions_on_name"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

end
