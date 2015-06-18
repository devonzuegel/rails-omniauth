module AccountHelper
  THEMES = ["light", "dark"]
  
  def theme
    default_theme = THEMES.first
    user_theme = current_user.account.theme if current_user
    !!(THEMES.index user_theme) ? user_theme : default_theme
  end

end
