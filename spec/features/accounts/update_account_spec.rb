feature 'Update account settings', :omniauth do
  before(:all) do
    @account_form = {
      path: account_path,
      signed_in: true,
      submit_value: 'Save'
    }
  end

  feature 'Visitor:' do
    # Scenario: Visitor can't view & update account settings
    #   Given I am a visitor
    #   When I go to /account
    #   Then I can't view and update settings
    scenario "visitor can't view & update account settings" do
      visit @account_form[:path]
      expect(page).to have_content 'You need to sign in for access to this page.'
    end
  end

  feature 'User:' do
    before(:each) { sign_in_feature }

    # Scenario: User can give nil name
    #   Given I am a user
    #   When I update my account with a nil name
    #   Then that field is updated with nil
    scenario 'user can give nil name' do
      expect(current_user).to have_attributes(auth_mock_hash['info'])
      details = {
        name: 'account[user_attributes]',
        attributes: { name: nil }
      }
      fill_form_and_save(@account_form.merge details)
      expect(page).to have_content 'Your account was updated successfully'
      expect(current_user).to have_attributes(name: nil)
    end

    # Scenario: User can give "" name
    #   Given I am a user
    #   When I update my account with a blank name
    #   Then that field is updated with nil
    scenario 'user can give blank name' do
      expect(current_user).to have_attributes(auth_mock_hash['info'])
      details = {
        name: 'account[user_attributes]',
        attributes: { name: ' ' }
      }
      fill_form_and_save(@account_form.merge(details))
      expect(page).to have_content 'Your account was updated successfully'
      expect(current_user).to have_attributes(name: nil)
    end

    # Scenario: User can give a non-blank name
    #   Given I am a user
    #   When I update my account with a name
    #   Then that field is updated with that name
    scenario 'user can give non-blank name' do
      values = @account_form.merge(
        name: 'account[user_attributes]',
        attributes: { name: 'James Smith' }
      )
      fill_form_and_save(values)
      expect(page).to have_content 'Your account was updated successfully'
      expect(current_user).to have_attributes(name: 'James Smith')
    end

    # Scenario: User can UPDATE his/her theme
    #   Given I am a user
    #   When I go to account settings, change the theme, and save
    #   Then my theme is changed and I see the theme I chose
    scenario 'user can update his/her theme' do
      Account.themes.each do |theme|
        visit @account_form[:path]
        select theme, from: 'account[theme]'
        click_button @account_form[:submit_value]
        expect(page).to have_selector("body.#{theme}")
      end
    end

    # Scenario: User can generate a new API token
    #   Given I am a user
    #   When I go to account settings and click 'Generate a new token'
    #   Then my API token is changed and it is updated
    scenario 'user can generate a new API token' do
      visit @account_form[:path]
      expect { click_link 'generate a new token' }.to change { current_visitor.api_key }
    end
  end
end
