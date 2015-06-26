module AccountHelper

  def theme
    default_theme = Account.themes.first
    if current_user != nil && current_user.account
      user_theme = current_user.account.theme
      !!(Account.themes.index user_theme) ? user_theme : default_theme
    else 
      default_theme
    end
  end

end
