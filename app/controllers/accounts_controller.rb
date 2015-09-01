# /zen-writer/app/controllers/accounts_controller.rb
class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account

  def show
  end

  def update
    if @account.update Utils.blank_params_to_nil(account_params)
      redirect_to account_path, flash: { notice: 'Your account was updated successfully' }
    else
      @account.errors.full_messages
      redirect_to account_path, flash: { error: @account.errors.full_messages }
    end
  end

  def token
    current_visitor.new_api_key
    redirect_to account_path, flash: { notice: 'Your new API key has been updated' }
  end

  private

  def set_account
    @account = current_user.account
  end

  def account_params
    params.require(:account).permit(
      :theme, :public_posts, :timezone,
      user_attributes: [:name, :first_name, :middle_name, :last_name, :id, :image]
    )
  end
end
