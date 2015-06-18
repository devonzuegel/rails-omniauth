module AccountHelper
  
  def theme
    default_theme = Account.themes.first
    user_theme = current_user.account.theme if current_user
    !!(THEMES.index user_theme) ? user_theme : default_theme
  end

end
