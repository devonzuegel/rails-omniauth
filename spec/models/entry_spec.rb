require 'rails_helper'

RSpec.describe Entry, type: :model do

  before(:each) { @entry = FactoryGirl.create(:entry) }

  subject { @entry }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:public) }

  it "factory entry created as expected" do
    expect(@entry.title).to match "MyString"
    expect(@entry.body).to match "MyText"
  end

  it "can be assigned a user" do
    expect(@entry.user).to be nil
    @user = FactoryGirl.create(:user)
    @entry.user = @user
    @entry.save
    expect(@entry.user).to be @user
  end

  it "can't have a blank or nil title"

end
