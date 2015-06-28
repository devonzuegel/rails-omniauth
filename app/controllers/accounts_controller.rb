class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account

  def show
  end

  def update
    if @account.update Utils.blank_params_to_nil(account_params)
      redirect_to account_path, flash: {
        notice: 'Your account was updated successfully'
      }
    else
      puts @account.errors.full_messages
      redirect_to account_path, flash: {
        error: @account.errors.full_messages
      }
    end
  end

  def edit
    redirect_to account_path
  end

  private

  def set_account
    @account = current_user.account
  end

  def account_params
    params.require(:account).permit(
      :theme, :public_posts,
      user_attributes: [:first_name, :last_name, :id]
    )
  end
end
