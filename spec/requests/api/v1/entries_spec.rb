describe 'Entries API' do
  ENTRIES_ENDPOINT = '/api/v1/entries'
  SEARCH_ENDPOINT  = "#{ENTRIES_ENDPOINT}/search"

  describe '/index' do
    before(:all) { create_dummy_entries }

    it 'should respond with filtered entries for a request with a valid api tokey' do
      %w(just_mine default others foobar).each do |filter|
        get ENTRIES_ENDPOINT, 'api_key' => @visitor.api_key, 'filter' => filter
        assert_response :success
        actual = parsed(response).map { |r| r['id'] }
        expected = Entry.filter(@visitor, filter).map { |r| r['id'] }
        expect(actual).to match_array expected
      end
    end

    it 'should respond with filtered entries for a request with no api tokey' do
      %w(just_mine default others foobar).each do |filter|
        get ENTRIES_ENDPOINT, 'filter' => filter
        assert_response :success
        actual = parsed(response).map { |r| r['id'] }
        expected = Entry.filter(nil, filter).map { |r| r['id'] }
        expect(actual).to match_array expected
      end
    end

    it "should alert us that we've passed an invalid api key" do
      get ENTRIES_ENDPOINT, 'api_key' => 'BAD API KEY'
      assert_response :unauthorized
      expect(response.body).to match(Visitor::INVALID_API_KEY)
    end
  end

  describe '/search', :elasticsearch do
    before(:each) do
      Entry.delete_all
      @titles = ['blah blah', 'this is a test']
      @query  = @titles.first.split.first
      @titles.each { |str| create(:entry, title: str) }
      recreate_all_indices!
    end

    it 'should return only results relevant to the first title in @titles' do
      get SEARCH_ENDPOINT, 'q' => @query
      assert_response :success
      response_titles = parsed(response).map { |e| e['title'] }
      expect(response_titles).to match_array [@titles.first]
    end

    it 'should require an API key'
  end
end
