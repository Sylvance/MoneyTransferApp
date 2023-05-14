# frozen_string_literal: true

# Account balance
class AccountBalance < ApplicationRecord
  belongs_to :user

  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  def credit(incoming_amount)
    self.amount = amount.to_f + incoming_amount.to_f
    save!
  end

  def debit(outgoing_amount)
    self.amount = amount.to_f - outgoing_amount.to_f
    save!
  end
end
