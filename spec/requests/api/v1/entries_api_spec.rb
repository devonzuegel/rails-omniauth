describe 'Entries API' do
  ENTRIES_ENDPOINT = '/api/v1/entries'

  describe '/index' do
    let(:filters) { Entry.filters + ['foobar'] }
    before(:all)  { create_dummy_entries }

    describe 'request with filter but no query:' do
      it 'should respond with filtered entries for a request provided a valid api tokey' do
        filters.each do |filter|
          get ENTRIES_ENDPOINT, api_key: @visitor.api_key, filter: filter
          assert_response :success
          actual = parsed(response).map { |r| r['id'] }
          expected = Entry.filter(visitor: @visitor, filter: filter).map { |r| r['id'] }
          expect(actual).to match_array expected
        end
      end

      it 'should respond with filtered entries for a request provided no api tokey' do
        filters.each do |filter|
          get ENTRIES_ENDPOINT, filter: filter
          assert_response :success

          actual = parsed(response).map { |r| r['id'] }
          expected = Entry.filter(visitor: nil, filter: filter).map { |r| r['id'] }
          expect(actual).to match_array expected
        end
      end

      it "should alert us that we've passed an invalid api key" do
        get ENTRIES_ENDPOINT, api_key: 'BAD API KEY'
        assert_response :unauthorized
        expect(response.body).to match(Visitor::INVALID_API_KEY)
      end
    end

    describe 'requests with filter and query' do
      before(:all) do
        @titles = ['blah blah', 'this is a test']
        @query  = @titles.first.split.first
        @titles.each { |t| create_dummy_entries(clear: false, title: t) }

        # There should be 6 dummy entries with Lorem Ipsum titles, 6 with title #1,
        # and 6 with title #2, and those 6 for each title fall under one of each of
        # the "dummy" categories which are permutations of private/public and
        # visitor/friend/orphan.
        expect(Entry.count).to eq(18)
        recreate_all_indices!
      end

      it 'should return only results relevant to the first title in @titles' do
        filters.each do |filter|
          get ENTRIES_ENDPOINT, api_key: @visitor.api_key, filter: filter, query: @query
          assert_response :success

          actual = parsed(response).map { |r| r['id'] }
          expected = Entry.filtered_search(query: @query, visitor: @visitor, filter: filter).map { |r| r['id'] }
          expect(actual).to match_array expected
        end
      end
    end
  end
end
