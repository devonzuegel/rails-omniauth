describe 'Entries API' do
  before(:all) { create_dummy_entries }

  it '...' do
    get '/api/v1/entries', 'api_key' => @visitor.api_key
    assert_response :success
    print 'entries: '.black
    ap response.body
  end

  it "should alert us that we've passed an invalid api key" do
    get '/api/v1/entries', 'api_key' => 'BAD API KEY'
    assert_response :unauthorized
    expect(response.body).to match(Visitor::INVALID_API_KEY)
  end
end
