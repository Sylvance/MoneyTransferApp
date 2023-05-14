# frozen_string_literal: true

class CreateAccountTopUps < ActiveRecord::Migration[7.0]
  def change
    create_table :account_top_ups do |t|
      t.references :user, null: false, foreign_key: true, unique: true
      t.float :amount

      t.timestamps
    end
  end
end
