# app/controllers/api/api_controller.rb
class Api::ApiController < ActionController::Base
  include ActionController::ImplicitRender

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

    response_json = { status: Visitor::INVALID_API_KEY }
    respond_with :api, :v1, response_json, status: :unauthorized
  end
end
