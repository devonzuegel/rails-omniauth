describe Authenticable, type: :concern do
  it 'must have a unique api key' do
    repeated_token = create(:visitor).api_key
    expect(build(:visitor, api_key: repeated_token)).to be_invalid
  end

  it 'will be given a new api key if api_key: nil on save' do
    visitor = create(:visitor, api_key: nil)
    expect(visitor.api_key).to_not be nil
    expect(visitor).to be_valid
  end

  it 'generates & saves a new api key upon request' do
    visitor = create(:visitor)
    original_key = visitor.api_key
    visitor.new_api_key
    expect(visitor.api_key).to_not be original_key
  end
end
