describe 'Entries API' do
  describe 'GET /entries' do
    before(:all) { create_dummy_entries }

    # Feature: Response for public entries
    #   When I'm not authenticated and I `GET /entries`
    #   Then I receive json enumerating all public entries
    it 'returns all the public entries' do
      get '/entries', {}, 'Accept' => 'application/json'
      expect(response.status).to eq 200

      response_entries = JSON.parse(response.body).map { |e| e['id'] }
      expected_entries = @entries.select { |e| @entries[e].public? }.values.map(&:id)
      expect(response_entries).to match_array expected_entries
    end
  end
end
