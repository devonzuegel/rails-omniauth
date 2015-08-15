describe 'API' do
  describe 'GET zenwriter.io/api/v1/entries' do
    before(:all) do
      @user    = create(:user)
      @visitor = create(:visitor, user: @user)
      @friend  = create(:user)
      # create_dummy_entries
    end

    it '...' do
      get '/api/v1/entries', 'Accept' => 'application/json'
      ap JSON.parse(response.body)
    end

    it '...' do
      # get '/api/v1/entries', nil, { 'HTTP_AUTHORIZATION' => @user.api_key }
      puts '-----------------------------------------------'.black
      puts "api_key: #{@user.api_key.white}\n".black
      get '/api/v1/entries', { entry: 'blah' }, encoded_credentials
      puts '-----------------------------------------------'.black
      # headers = { 'Authorization' => %(Token token="#{@user.api_key}") }
      # ap @user
      # ap HTTParty.get('/api/v1/entries', headers: headers)
    end
  end
end

def encoded_credentials(user = nil)
  key = (user || @user).api_key
  credentials = ActionController::HttpAuthentication::Token.encode_credentials(key)
  { 'HTTP_AUTHORIZATION' => credentials }
end
