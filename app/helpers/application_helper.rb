# app/helpers/application_helper.rb
module ApplicationHelper
  private

  def correct_user!(user = nil)
    user ||= User.find(params[:id])
    redirect_to root_url, alert: 'Access denied.' unless current_user == user
  end

  def authenticate_user!
    alert = 'You need to sign in for access to this page.'
    redirect_to(root_url, alert: alert) unless current_user
  end

  def controller_info
    gon.controller      = params[:controller]
    gon.action          = params[:action]
    gon.current_user    = current_user
    gon.current_visitor = current_visitor
  end

  def current_user
    User.find(session[:user_id]) if session.present? && session[:user_id].present?
  rescue StandardError
    nil
  end

  def current_visitor
    log_visitor unless visitor_logged?
    Visitor.where(ip_address: request.remote_ip).first
  end

  def log_visitor
    ip = request.remote_ip
    matches = Visitor.where(ip_address: ip)

    visitor = matches.first || Visitor.create(ip_address: ip)
    visitor.update(view_count: visitor.view_count + 1, user: current_user)
    session[:visitor_id] = visitor.id

    visitor
  end

  def visitor_logged?
    session.present? && session[:visitor_id].present?
  end

  def returning_visitor?
    !Visitor.where(ip_address: request.remote_ip).empty?
  end

  def signed_in?
    current_user.present?
  end
end
