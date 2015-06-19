class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account
  
  def show
  end

  def update
    if @account.update blank_params_to_nil(account_params)
      redirect_to account_path, flash: { 
        notice: "Your account was updated successfully" 
      }
    else
      redirect_to account_path, flash: { 
        error: @account.errors.full_messages
      }
    end
  end


  private

    def set_account
      @account = current_user.account
    end

    def account_params
      params.require(:account).permit(
        :theme, :public_posts, 
        user_attributes: [ :name, :first_name, :middle_name, :last_name, :id ]
      )
    end

end
