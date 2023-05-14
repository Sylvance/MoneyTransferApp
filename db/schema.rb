# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_507_073_690) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'account_balances', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.float 'amount'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_account_balances_on_user_id'
  end

  create_table 'account_top_ups', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.float 'amount'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_account_top_ups_on_user_id'
  end

  create_table 'notifications', force: :cascade do |t|
    t.bigint 'sender_id', null: false
    t.bigint 'recipient_id', null: false
    t.text 'message'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['recipient_id'], name: 'index_notifications_on_recipient_id'
    t.index ['sender_id'], name: 'index_notifications_on_sender_id'
  end

  create_table 'transactions', force: :cascade do |t|
    t.bigint 'sender_id', null: false
    t.bigint 'recipient_id', null: false
    t.float 'amount'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['recipient_id'], name: 'index_transactions_on_recipient_id'
    t.index ['sender_id'], name: 'index_transactions_on_sender_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.string 'phone_number'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'account_balances', 'users'
  add_foreign_key 'account_top_ups', 'users'
  add_foreign_key 'notifications', 'users', column: 'recipient_id'
  add_foreign_key 'notifications', 'users', column: 'sender_id'
  add_foreign_key 'transactions', 'users', column: 'recipient_id'
  add_foreign_key 'transactions', 'users', column: 'sender_id'
end
