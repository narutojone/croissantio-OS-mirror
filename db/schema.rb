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

ActiveRecord::Schema.define(version: 20170901124931) do

  create_table "app_settings", force: :cascade do |t|
    t.string "refresh_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token"
  end

  create_table "article_topics", force: :cascade do |t|
    t.integer "article_id"
    t.integer "topic_id"
    t.index ["article_id"], name: "index_article_topics_on_article_id"
    t.index ["topic_id"], name: "index_article_topics_on_topic_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "body"
    t.string "image"
    t.string "user_id"
    t.boolean "posted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "topic_name"
    t.datetime "date"
    t.index ["slug"], name: "index_articles_on_slug", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "resources_count", default: 0
    t.string "icon"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "facebook_ids", force: :cascade do |t|
    t.string "fb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "subscribed", default: false
  end

  create_table "facebook_links", force: :cascade do |t|
    t.string "link"
    t.boolean "sent", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "desc"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "resource_categories", force: :cascade do |t|
    t.integer "resource_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_resource_categories_on_category_id"
    t.index ["resource_id"], name: "index_resource_categories_on_resource_id"
  end

  create_table "resources", force: :cascade do |t|
    t.integer "grade"
    t.string "website"
    t.string "title"
    t.string "link"
    t.string "slug"
    t.text "description"
    t.string "author"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "resource_type"
    t.string "category_name"
    t.index ["slug"], name: "index_resources_on_slug", unique: true
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.index ["slug"], name: "index_topics_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
