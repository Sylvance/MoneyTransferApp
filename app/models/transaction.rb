# frozen_string_literal: true

# Transaction
class Transaction < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates :amount, numericality: { greater_than: 0 }

  after_commit :send_notification
  after_create :instruct

  def send_notification
    message = "You received #{number_to_currency(amount)} from #{sender.email}"
    recipient.deliver_notification(message, sender, recipient)
  end

  def instruct
    sender.account_balance.debit(amount)
    recipient.account_balance.credit(amount)
  end
end
