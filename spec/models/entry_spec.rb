require 'rails_helper'

RSpec.describe Entry, type: :model do

  before(:each) { @entry = FactoryGirl.create(:entry) }

  subject { @entry }

  it { should respond_to(:title) }

  it "#title returns a string" do
    expect(@entry.title).to match "MyString"
  end

  it "can be assigned a user" do
    expect(@entry.user).to be nil
    @user = FactoryGirl.create(:user)
    @entry.user = @user
    @entry.save
    expect(@entry.user).to be @user
  end

end
