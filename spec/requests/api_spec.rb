describe 'API' do
  describe 'GET zenwriter.io/api/v1/entries' do
    before(:all) do
      @user    = create(:user)
      @visitor = create(:visitor, user: @user)
      @friend  = create(:user)
      create_dummy_entries
    end

    it '...' do
      get '/api/v1/entries', 'Accept' => 'application/json'
      ap JSON.parse(response.body)
    end
  end
end
