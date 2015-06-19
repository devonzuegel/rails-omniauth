describe User do

  before(:each) { @user = FactoryGirl.create(:user) }

  subject { @user }

  it { should respond_to(:name) }

  it "factory user created as expected" do
    expect(@user).to be_valid
    expect(@user.name).to match 'Test Middlename User'
    expect(@user.provider).to match 'facebook'
  end

end
