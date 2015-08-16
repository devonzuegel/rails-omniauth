# app/controllers/api/api_controller.rb
class Api::ApiController < ActionController::Base
  respond_to :json
  protect_from_forgery with: :null_session
  before_action :authenticate

  private

  # If given no token, assume the user just wants public information.
  # If given a valid token, retrieve the correct @visitor.
  # If given an invalid token, fail the request and explain.
  def authenticate
    token = params['api_key']
    return if token.nil?

    @visitor = Visitor.find_by_api_key(token)
    return if @visitor.present?

    render json: { status: Visitor::INVALID_API_KEY }, status: :unauthorized
  end
end
