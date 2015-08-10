# encoding: utf-8
require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe 'basic entry' do
    before(:each) { @entry = create(:entry) }

    it { should respond_to(:title) }
    it { should respond_to(:body) }
    it { should respond_to(:public) }

    it 'factory entry created as expected' do
      expect(@entry).to be_valid
    end

    it 'can be assigned a user' do
      expect(@entry.user).to be nil
      @user = create(:user)
      @entry.user = @user
      @entry.save
      expect(@entry.user).to be @user
    end

    it 'is not public' do
      expect(@entry.public?).to eq false
    end

    it 'is public' do
      @entry[:public] = true
      @entry.save
      expect(@entry.public?).to eq true
    end
  end

  it 'should be invalid with a blank or nil title' do
    expect(build(:entry, title: nil)).to_not be_valid
    expect(build(:entry, title: '')).to_not be_valid
    expect(build(:entry, title: '   ')).to_not be_valid
  end
end
