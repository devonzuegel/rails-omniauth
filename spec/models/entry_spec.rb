require 'rails_helper'

RSpec.describe Entry, type: :model do

  before(:each) { @entry = FactoryGirl.create(:entry) }

  subject { @entry }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:public) }

  it "factory entry created as expected" do
    expect(@entry).to be_valid
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

  it "should be invalid with a blank or nil title" do
    FactoryGirl.build(:entry, title: nil).should_not be_valid
    FactoryGirl.build(:entry, title: "").should_not be_valid
    FactoryGirl.build(:entry, title: "   ").should_not be_valid
  end

end
