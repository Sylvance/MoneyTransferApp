# frozen_string_literal: true

class PagesController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :require_login

  def home
    @show_page = params[:page] || :empty

    if logged_in?
      case @show_page
      when :dashboard
        @user = User.find(session[:user_id])
      when :transaction
        @transaction = Transaction.new
      when :topup
        @account_top_up = AccountTopUp.new
      end
    else
      case @show_page
      when :login
        @user = User.none
      when :register
        @user = User.new
      end
    end
  end

  def create_transaction
    amount = transaction_params[:amount].to_f
    sender = User.find(session[:user_id])
    recipient = User.find_by(email: transaction_params[:recipient_id])

    @transaction = Transaction.new(sender: sender, recipient: recipient, amount: amount)

    if @transaction.save
      response(notice: 'Transaction was successfully created.', params: { page: :dashboard })
    else
      @users = User.all
      response(notice: 'Transaction was not created.', params: { page: :dashboard })
    end
  end

  def create_account_top_up
    amount = account_top_up_params[:amount].to_f
    account_user = User.find(session[:user_id])

    @account_top_up = AccountTopUp.new(user: account_user, amount: amount)

    if @account_top_up.save
      response(notice: 'Account Top Up was successfully created.', params: { page: :dashboard })
    else
      @users = User.all
      response(notice: 'Account Top Up was not created.', params: { page: :dashboard })
    end
  end

  def create_user
    @user = User.new(user_params)

    if @user.save
      response(notice: 'User was successfully created.', params: { page: :dashboard })
    else
      response(notice: 'User was not created.', params: { page: :dashboard })
    end
  end

  def create_session
    @user = User.find_by(email: session_params[:email])

    if @user&.authenticate(session_params[:password])
      session[:user_id] = @user.id
      response(notice: 'Login successful!', params: { page: :dashboard })
    else
      response(notice: 'Invalid login details.', params: { page: :dashboard })
    end
  end

  def delete_session
    if session[:user_id].present?
      session[:user_id] = nil
      response(notice: 'Logout successful!', params: { page: :dashboard })
    else
      response(notice: 'Failed to log out.', params: { page: :dashboard })
    end
  end

  private

  def response(alert: '', notice: '', params: {})
    flash[:alert] = alert
    flash[:notice] = notice
    render :home, locals: params
  end

  def require_login
    render :home, notice: 'Log in first to continue.' unless logged_in?
  end  

  def logged_in?
    session[:user_id].present?
  end

  def session_params
    params.require(:user).permit(:email, :password)
  end

  def user_params
    params.require(:user).permit(:email, :phone_number, :password)
  end

  def transaction_params
    params.require(:transaction).permit(:sender_id, :recipient_id, :amount)
  end

  def account_top_up_params
    params.require(:account_top_up).permit(:amount)
  end
end
