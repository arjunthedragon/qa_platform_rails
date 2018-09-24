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

ActiveRecord::Schema.define(version: 20180622125104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "answer_requests", force: :cascade do |t|
    t.integer  "requested_user_id"
    t.integer  "post_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["post_id"], name: "index_answer_requests_on_post_id", using: :btree
    t.index ["requested_user_id"], name: "index_answer_requests_on_requested_user_id", using: :btree
  end

  create_table "answers", force: :cascade do |t|
    t.text     "description",                     null: false
    t.integer  "answered_by_id"
    t.boolean  "is_accepted",     default: false
    t.integer  "post_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "net_votes_count"
    t.index ["answered_by_id"], name: "index_answers_on_answered_by_id", using: :btree
    t.index ["is_accepted"], name: "index_answers_on_is_accepted", using: :btree
    t.index ["post_id"], name: "index_answers_on_post_id", using: :btree
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable_type_and_attachable_id", using: :btree
  end

  create_table "audit_logs", force: :cascade do |t|
    t.string   "event"
    t.string   "message"
    t.integer  "auditor_id"
    t.string   "auditor_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "badges", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "description",      null: false
    t.integer  "commented_by_id"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
    t.index ["commented_by_id"], name: "index_comments_on_commented_by_id", using: :btree
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "edit_suggestions", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "status",                   default: "open"
    t.integer  "edit_suggestionable_id"
    t.string   "edit_suggestionable_type"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "answer_suggester_id"
    t.integer  "question_suggester_id"
    t.index ["edit_suggestionable_type", "edit_suggestionable_id"], name: "index_edit_suggestions_on_edit_suggestionable_type_and_id", using: :btree
  end

  create_table "favourates", force: :cascade do |t|
    t.integer  "favoured_by_id"
    t.integer  "favourate_post_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["favourate_post_id"], name: "index_favourates_on_favourate_post_id", using: :btree
    t.index ["favoured_by_id"], name: "index_favourates_on_favoured_by_id", using: :btree
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "feedback_type"
    t.integer  "user_id"
    t.string   "feedbackable_type"
    t.integer  "feedbackable_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["feedback_type"], name: "index_feedbacks_on_feedback_type", using: :btree
    t.index ["feedbackable_type", "feedbackable_id"], name: "index_feedbacks_on_feedbackable_type_and_feedbackable_id", using: :btree
    t.index ["user_id"], name: "index_feedbacks_on_user_id", using: :btree
  end

  create_table "post_categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_category_id"
    t.integer  "department_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["department_id"], name: "index_post_categories_on_department_id", using: :btree
    t.index ["name"], name: "index_post_categories_on_name", using: :btree
    t.index ["parent_category_id"], name: "index_post_categories_on_parent_category_id", using: :btree
  end

  create_table "post_visits", force: :cascade do |t|
    t.integer  "post_id"
    t.string   "visitor_type", default: "guest"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["post_id"], name: "index_post_visits_on_post_id", using: :btree
    t.index ["visitor_type"], name: "index_post_visits_on_visitor_type", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",                             null: false
    t.string   "status",           default: "open", null: false
    t.integer  "user_id"
    t.integer  "post_category_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["post_category_id"], name: "index_posts_on_post_category_id", using: :btree
    t.index ["status"], name: "index_posts_on_status", using: :btree
    t.index ["title"], name: "index_posts_on_title", using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "first_name", default: ""
    t.string   "last_name",  default: ""
    t.date     "dob"
    t.integer  "image_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["first_name"], name: "index_profiles_on_first_name", using: :btree
    t.index ["last_name"], name: "index_profiles_on_last_name", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.text     "description",     null: false
    t.integer  "post_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "net_votes_count"
    t.index ["post_id"], name: "index_questions_on_post_id", using: :btree
  end

  create_table "tag_posts", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_tag_posts_on_post_id", using: :btree
    t.index ["tag_id"], name: "index_tag_posts_on_tag_id", using: :btree
  end

  create_table "tag_prediction_infos", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "posts_count"
    t.integer  "questioner_experience"
    t.integer  "net_question_votes"
    t.integer  "average_question_length"
    t.integer  "centrality"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "popularity_status",                   default: "unpopular"
    t.integer  "posts_count_ratio_cents"
    t.integer  "questioner_experience_ratio_cents"
    t.integer  "net_question_votes_ratio_cents"
    t.integer  "average_question_length_ratio_cents"
    t.integer  "centrality_ratio_cents"
    t.integer  "popularity_value",                    default: 0
    t.index ["tag_id"], name: "index_tag_prediction_infos_on_tag_id", using: :btree
  end

  create_table "tag_weights", force: :cascade do |t|
    t.integer  "tag1_id"
    t.integer  "tag2_id"
    t.integer  "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag1_id"], name: "index_tag_weights_on_tag1_id", using: :btree
    t.index ["tag2_id"], name: "index_tag_weights_on_tag2_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_badges", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "badge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["badge_id"], name: "index_user_badges_on_badge_id", using: :btree
    t.index ["user_id"], name: "index_user_badges_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "is_suspended",           default: false
    t.string   "phone_number",                           null: false
    t.string   "authentication_token",                   null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "profile_id"
    t.integer  "experience_value"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true, using: :btree
    t.index ["profile_id"], name: "index_users_on_profile_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.string   "vote_type"
    t.integer  "voter_id"
    t.string   "voterable_type"
    t.integer  "voterable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["vote_type"], name: "index_votes_on_vote_type", using: :btree
    t.index ["voter_id", "vote_type", "voterable_type", "voterable_id"], name: "voter_main_attributes_unique_index", unique: true, using: :btree
    t.index ["voter_id"], name: "index_votes_on_voter_id", using: :btree
    t.index ["voterable_type", "voterable_id"], name: "index_votes_on_voterable_type_and_voterable_id", using: :btree
  end

end
