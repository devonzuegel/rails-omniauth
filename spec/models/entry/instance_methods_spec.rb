# encoding: utf-8
require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe 'misc instance methods' do
    it '@entry.orphan? == false when the entry has an owner' do
      @entry = create(:entry, user: create(:user))
      expect(@entry.orphan?).to eq false
    end

    it '@entry.orphan? == true when the entry has no owner' do
      @entry = create(:entry, user: nil)
      expect(@entry.orphan?).to eq true
    end

    it '@entry.owned_by?(_user: @user) == false when @user is not @entry\'s owner' do
      @user  = build(:user)
      @entry = build(:entry, user: nil)
      expect(@entry.owned_by?(_user: @user)).to eq(false)
    end

    it '@entry.owned_by?(_user: @user) == true when @user is @entry\'s owner' do
      @user  = build(:user)
      @entry = build(:entry, user: @user)
      expect(@entry.owned_by?(_user: @user)).to eq(true)
    end

    it '@entry.visible_to?(_user: @user) == false when @user is not @entry\'s owner' do
      @user  = build(:user)
      @entry = build(:entry, public: false)
      expect(@entry.visible_to?(_user: @user)).to eq(false)
    end

    it '@entry.visible_to?(_user: @user) == true when @user is @entry\'s owner' do
      @user  = build(:user)
      @entry = build(:entry, public: true)
      expect(@entry.visible_to?(_user: @user)).to eq(true)
    end
  end
end
