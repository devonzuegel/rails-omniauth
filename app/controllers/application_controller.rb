# /app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :controller_info

  helper_method :current_user, :signed_in?, :correct_user!

  private # -----------------------------------------------------------

  def signed_in?
    current_user != nil
  end

  def correct_user!(user = nil)
    user ||= User.find(params[:id])
    redirect_to root_url, alert: 'Access denied.' if current_user != user
  end

  def authenticate_user!
    alert = 'You need to sign in for access to this page.'
    redirect_to(root_url, alert: alert) unless current_user
  end

  def controller_info
    gon.controller = params[:controller]
    gon.action     = params[:action]
  end
end
