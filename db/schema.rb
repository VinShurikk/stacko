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

ActiveRecord::Schema.define(version: 20160321092632) do

  create_table "answer_votes", force: true do |t|
    t.boolean  "action"
    t.integer  "user_id"
    t.integer  "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", force: true do |t|
    t.integer  "question_id"
    t.string   "text"
    t.integer  "user_id"
    t.integer  "rating",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.string   "text"
    t.integer  "question_id"
    t.integer  "comment_id"
    t.integer  "rating",      default: 0
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "question_votes", force: true do |t|
    t.boolean  "action"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.string   "text"
    t.integer  "rating",     default: 0
    t.integer  "view_count", default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "title",      default: "", null: false
    t.integer  "user_id"
  end

  create_table "questions_tags", id: false, force: true do |t|
    t.integer "question_id", null: false
    t.integer "tag_id",      null: false
  end

  create_table "tags", force: true do |t|
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: true do |t|
    t.string   "login"
    t.string   "password"
    t.date     "last_login"
    t.integer  "rating",     default: 0
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "email"
  end

end
