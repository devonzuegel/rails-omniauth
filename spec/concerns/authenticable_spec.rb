describe Authenticable, type: :concern do
  it 'must have a unique api key' do
    repeated_token = create(:visitor).new_api_key
    expect(build(:visitor, api_key: repeated_token)).to be_invalid
  end

  it 'may have a nil api key' do
    expect(build(:visitor, api_key: nil)).to be_valid
  end

  it 'will be given a new api key if api_key:nil on save' do
    user = create(:visitor, api_key: nil)
    expect(user.api_key).to_not be nil
  end
end
