require 'rails_helper'

RSpec.describe Account, type: :model do

  before(:each) {
    @account = FactoryGirl.create(:account)
    @user = FactoryGirl.create(:user)
  }

  subject { @account }

  it { should respond_to(:theme) }
  it { should respond_to(:public_posts) }

  it "factory account created as expected" do
    expect(@account.theme).to match Account.themes.first
    expect(@account.public_posts).to match false
  end

  it "can be assigned a user" do
    expect(@account.user).to be nil
    @account.user = @user
    @account.save
    expect(@account.user).to be @user
  end

end
