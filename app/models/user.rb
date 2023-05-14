# frozen_string_literal: true

# User
class User < ApplicationRecord
  has_many :sent_transactions, class_name: 'Transaction', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_transactions, class_name: 'Transaction', foreign_key: 'recipient_id', dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :account_top_ups. dependent: :destroy

  has_one :account_balance, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true

  def balance
    account_balance.amount
  end

  def all_transactions
    Transaction.where('sender_id = :user_id OR recipient_id = :user_id', user_id: id)
  end

  def total_sent_amount
    sent_transactions.sum(:amount)
  end

  def total_received_amount
    received_transactions.sum(:amount)
  end

  def deliver_notification(message, sender, recipient)
    notifications.create(message: message, sender: sender, recipient: recipient)
  end
end
