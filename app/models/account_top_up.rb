# frozen_string_literal: true

# Account TopUp
class AccountTopUp < ApplicationRecord
  belongs_to :user

  validates :amount, numericality: { greater_than: 0 }

  after_commit :send_notification
  after_create :instruct

  def send_notification
    message = "Your topup of #{number_to_currency(amount)} has been made to your account."
    user.deliver_notification(message, user, user)
  end

  def instruct
    user.account_balance.credit(amount)
  end
end
