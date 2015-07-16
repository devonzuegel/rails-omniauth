describe 'Entries API' do
  describe 'GET /entries' do
    before(:all) { create_dummy_entries }

    # Feature: Response for public entries
    #   When I'm not authenticated and I `GET /entries`
    #   Then I receive json enumerating all public entries
    it 'returns all the public entries' do
      get '/entries', { 'public' => true }, 'Accept' => 'application/json'
      expect(response.status).to eq 200

      response_entries = JSON.parse(response.body).map { |e| e['id'] }
      expected_entries = @entries.select { |e| @entries[e].public? }.values.map(&:id)
      expect(response_entries).to match_array expected_entries
    end

    it 'returns all entries visible to a visitor for each filter'
    #   do
    #     Entry.filters.each do |f|
    #       get '/entries', { 'filter' => f }, 'Accept' => 'application/json'
    #       expect(response.status).to eq 200

    #       response_entries = JSON.parse(response.body).map { |e| e['id'] }
    #       ap response_entries
    #       expected_entries = Entry.filter(session, f).values.map(&:id)
    #       expect(response_entries).to match_array expected_entries
    #     end
    #   end

    it 'returns a requested entry' do
      entry = @entries[:publ_ent]
      get "/entries/#{entry.id}", {}, 'Accept' => 'application/json'
      expect(response.status).to eq 200

      response_entry = JSON.parse(response.body)
      expect(response_entry['title']).to eq entry.title
      expect(response_entry['id']).to eq entry.id
      expect(response_entry['body']).to eq entry.body
    end

    it 'returns a failure message & redirects when requesting a non-existent entry' do
      entry = @entries[:priv_ent]
      get "/entries/#{entry.id}", {}, 'Accept' => 'application/json'
      expect(response.status).to eq 302
      expect(response.body).to match /You are being .+redirected/
    end
  end

  describe 'DELETE /entries/#{id}' do
    it "shouldn't allow us to delete entries that we don't own"
  end
end
