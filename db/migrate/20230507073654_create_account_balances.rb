class CreateAccountBalances < ActiveRecord::Migration[7.0]
  def change
    create_table :account_balances do |t|
      t.references :user, null: false, foreign_key: true, unique: true
      t.float :amount

      t.timestamps
    end
  end
end
