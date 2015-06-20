describe User do

  before(:each) { @user = FactoryGirl.create(:user) }

  subject { @user }

  it { should respond_to(:name) }

  it "factory user created as expected" do
    expect(@user).to be_valid
    expect(@user.name).to match 'Test Middlename User'
    expect(@user.provider).to match 'facebook'
  end

  it "mock auth user created as expected" do
    expect {
      @user = User.create_with_omniauth(auth_mock_hash)
    }.to change{ User.count }.by 1

    expect(@user).to have_attributes(auth_mock_hash['info'].merge({
      provider: auth_mock_hash['provider'],
      uid:      auth_mock_hash['uid']
    }))
  end

  it "mock user with nil info attributes created as expected" do
    info = {
      name:        nil,
      first_name:  nil,
      middle_name: nil, 
      last_name:   nil,
      email:       nil,
    }
    expect {
      @user = User.create_with_omniauth(auth_mock_hash.merge({ 'info' => info }))
    }.to change{ User.count }.by 1

    expect(@user).to have_attributes(Utils.blank_params_to_nil({
      provider: auth_mock_hash['provider'],
      uid:      auth_mock_hash['uid']
    }.merge(info) ))
  end

  it "mock user with \"\" info attributes created as expected" do
    info = {
      name:        "    ",
      first_name:  "    ",
      middle_name: "    ", 
      last_name:   "    ",
      email:       "    ",
    }
    expect {
      @user = User.create_with_omniauth(auth_mock_hash.merge({ 'info' => info }))
    }.to change{ User.count }.by 1

    expect(@user).to have_attributes(Utils.blank_params_to_nil({
      provider: auth_mock_hash['provider'],
      uid:      auth_mock_hash['uid']
    }.merge(info) ))
  end

end
