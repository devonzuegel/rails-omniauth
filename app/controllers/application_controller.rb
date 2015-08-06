# /app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include ApplicationHelper

  # Prevent CSRF attacks by raising an exception. For APIs, you may
  # want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :controller_info, :log_visitor # , :set_user

  # The following helper methods can be found in `application_helper.rb`
  helper_method :correct_user!, :authenticate_user!, :controller_info, :current_user,
                :current_visitor, :visitor_logged, :returning_visitor, :signed_in?

  # # TODO remove me
  # def set_user
  #   session[:user_id] = User.first.id
  # end
end
