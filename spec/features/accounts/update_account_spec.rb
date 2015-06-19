feature 'Update account settings', :omniauth do

  # Scenario: User can sign in with valid account
  #   Given I am a valid user
  #   When I go to my account
  #   Then I can view and update settings
  scenario "user can view & update their account settings" do
    signin
    expect(page).to have_content("Sign out")
  end

end