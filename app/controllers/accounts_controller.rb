class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account
  
  def show
  end

  def update
    if @account.update(account_params)
      redirect_to account_path
    else
      render :show
    end
  end


  private

    def set_account
      @account = current_user.account
    end

    def account_params
      params.require(:account).permit(
        :theme, :public_posts, 
        users_attributes: [ :name, :first_name, :middle_name, :last_name ]
      )
    end
end
