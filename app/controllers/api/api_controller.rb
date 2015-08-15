class Api::ApiController < ActionController::Base
  respond_to :json
  protect_from_forgery with: :null_session
  before_action :authenticate

  private

  def authenticate
    ap params
    token = params['api_key']
    unless token.nil?
      @user = User.find_by_api_key(token)
      session[:user_id] = @user.id
      current_user(@user)
      # log_visitor
    end
    # @visitor ||= log_visitor
    # ap @visitor
    # # return if token.nil?

    # @user = User.find_by_api_key(token) unless token.nil?
  end
end
