# Feature: Update my account
#   As a user
#   I want to update my account settings
feature "Update my account", :omniauth do


  # Scenario: Visitor cannot see account information
  #   Given I am a visitor
  #   When I go to /account
  #   I'll be redirected with an alert saying I need to sign in
  scenario "visitor cannot see account information" do
    visit account_path
    puts page.text
  end

  scenario "user can see account information" do
    signin
    visit account_path
    puts page.text
  end

end