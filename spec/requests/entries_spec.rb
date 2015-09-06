describe 'Entries API' do
  describe 'GET /entries' do
    before(:all) do
      @user    = create(:user)
      @visitor = create(:visitor, user: @user)
      @friend  = create(:user)
      create_dummy_entries
    end

    # Feature: Response for public entries
    #   When I'm not authenticated and I `GET /entries`
    #   Then I receive json enumerating all public entries
    it 'returns all the public entries' do
      get '/entries', { 'public' => true }, 'Accept' => 'application/json'
      expected_entries = @entries.select { |e| @entries[e].public? }.values.map(&:id)

      expect(response_entries(response)).to match_array expected_entries
    end

    it 'returns all entries visible to a visitor for each filter'
    # do
    # Entry.labeled_filters.each do |f|
    # label, filter = f[:label], f[:filter]
    # get '/entries', { 'filter' => filter }, 'Accept' => 'application/json'
    # puts "\n#{label}:".black
    # ap response_entries(response)
    # ap Entry.filter(visitor: @visitor, filter: filter).map { |e|
    #   { public: e.public, user_id: e.user_id, visitor_id: e.visitor_id }
    # }
    # end
    # end
    #   do
    #     Entry.filters.each do |f|
    #       get '/entries', { 'filter' => f }, 'Accept' => 'application/json'
    #       expect(response.status).to eq 200

    #       response_entries = JSON.parse(response.body).map { |e| e['id'] }
    #       ap response_entries
    #       expected_entries = Entry.filter(visitor: session, filter: f).values.map(&:id)
    #       expect(response_entries).to match_array expected_entries
    #     end
    #   end

    it 'returns a requested entry' do
      entry = @entries[:publ_ent]
      get "/entries/#{entry.id}", {}, 'Accept' => 'application/json'
      response_entry = parsed_response(response)

      expect(response_entry['title']).to eq entry.title
      expect(response_entry['id']).to eq entry.id
      expect(response_entry['body']).to eq entry.body
    end

    it 'returns a failure message & redirects when requesting a non-existent entry' do
      entry = @entries[:priv_ent]
      get "/entries/#{entry.id}", {}, 'Accept' => 'application/json'
      expect(response.status).to eq 302
      expect(response.body).to match(/You are being .+redirected/)
    end
  end

  # TODO
  # describe 'DELETE /entries/#{id}' do
  #   it "shouldn't allow us to delete entries that we don't own"
  # end
end

def response_entries(response)
  parsed_response(response).map { |e| e['id'] }
end

def parsed_response(response)
  expect(response.status).to eq 200
  JSON.parse(response.body)
end
