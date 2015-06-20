module Omniauth

  module Mock
    def auth_mock_hash
      {
        'provider' => 'facebook',
        'uid' => '123545',
        'info' => {
          'name' => 'mockuser',
          'first_name' => 'mock',
          'middle_name' => 'middlename',
          'last_name' => 'user',
          'email' => 'test@gmail.com'
        },
        'credentials' => {
          'token' => 'mock_token',
          'secret' => 'mock_secret'
        }
      }
    end

    def auth_mock
      OmniAuth.config.mock_auth[:facebook] = auth_mock_hash
    end

    def invalid_auth_mock
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    end
  end

  module SessionHelpers
    def signin
      visit root_path
      expect(page).to have_content %r"Sign in"i
      auth_mock
      click_link "Sign in"
      @current_user = User.where( provider: auth_mock['provider'],
                                  uid:      auth_mock['uid'].to_s ).first
    end

    def current_user
      User.find(@current_user.id) if @current_user
    end

    def signed_in?
      !!current_user
    end
  end

end
