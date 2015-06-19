module Omniauth

  module Mock
    def auth_mock
      OmniAuth.config.mock_auth[:facebook] = {
        'provider' => 'facebook',
        'uid' => '123545',
        'info' => {
          'name' => 'mockuser',
          'first_name' => 'mock',
          'middle_name' => 'middlename',
          'last_name' => 'user'
        },
        'credentials' => {
          'token' => 'mock_token',
          'secret' => 'mock_secret'
        }
      }
    end

    def invalid_auth_mock
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    end
  end

  module SessionHelpers
    def signin
      visit root_path
      expect(page).to have_content("Sign in")
      auth_mock
      click_link "Sign in"
    end
  end

end
