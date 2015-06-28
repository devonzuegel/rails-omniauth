require 'rails_helper'

RSpec.describe Entry, type: :model do
  before(:each) { @entry = FactoryGirl.create(:entry) }

  subject { @entry }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:public) }

  it 'factory entry created as expected' do
    expect(@entry).to be_valid
  end

  it 'can be assigned a user' do
    expect(@entry.user).to be nil
    @user = FactoryGirl.create(:user)
    @entry.user = @user
    @entry.save
    expect(@entry.user).to be @user
  end

  it 'should be invalid with a blank or nil title' do
    expect(FactoryGirl.build :entry, title: nil).to_not be_valid
    expect(FactoryGirl.build :entry, title: '').to_not be_valid
    expect(FactoryGirl.build :entry, title: '   ').to_not be_valid
  end
end
