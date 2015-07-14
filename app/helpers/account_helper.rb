# app/helpers/account_helper.rb
module AccountHelper
  include ApplicationHelper

  def theme
    default_theme = Account.themes.first
    if !current_user.nil? && current_user.account
      user_theme = current_user.account.theme
      valid_theme = !(Account.themes.index(user_theme).nil?)
      valid_theme ? user_theme : default_theme
    else
      default_theme
    end
  end
end
