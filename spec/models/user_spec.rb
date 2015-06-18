describe User do

  before(:each) { @user = FactoryGirl.create(:user) }

  subject { @user }

  it { should respond_to(:name) }

  it "factory user created as expected" do
    expect(@user.name).to match 'Test User'
    expect(@user.provider).to match 'facebook'
  end

end
