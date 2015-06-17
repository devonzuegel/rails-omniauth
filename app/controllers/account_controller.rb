class AccountController < ApplicationController
  before_action :set_account
  before_action -> { correct_user! @account }, only: [:edit, :update]

  def edit
  end

  def update
  end


  private

    def set_account
      @account = Account.find(params[:id]) if params[:id]
    end

end
