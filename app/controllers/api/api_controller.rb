class Api::ApiController < ActionController::Base
  respond_to :json
  before_action :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      ap session
      @user = User.find_by_api_key(token) unless token.nil?
      token.nil? || @user.present?
    end
  end
end
