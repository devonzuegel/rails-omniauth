describe 'Entries API' do
  before(:all) { create_dummy_entries }

  ENTRIES_ENDPOINT = '/api/v1/entries'

  describe '/index' do
    it 'should responde with filtered entries for a request with a valid api tokey' do
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
end
