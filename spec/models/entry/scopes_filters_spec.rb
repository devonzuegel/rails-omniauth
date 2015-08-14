# encoding: utf-8
require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe 'scopes & filter:' do
    before(:all) do
      Entry.delete_all
      @user    = create(:user)
      @visitor = create(:visitor, user: @user)
      @friend  = create(:user)

      create_dummy_entries
    end

    it '.is_public should only surface public entries' do
      public_entries = Entry.is_public
      included = @entries.filtered_vals(:user_ent_1, :publ_ent, :publ_orph)
      expect(public_entries.sort).to match_array(included.sort)
    end

    it '.visible_to(user) should only surface entries visible to user' do
      visible = Entry.visible_to(user: @user)
      included = @entries.filtered_vals(:user_ent_1, :user_ent_2, :publ_ent, :publ_orph)
      expect(visible.count).to eq(4)
      expect(visible).to match_array(included)
    end

    it '.owned_by(user: user) should only surface entries owned by user' do
      owned_by = Entry.owned_by(user: @user)
      included = @entries.filtered_vals(:user_ent_1, :user_ent_2)
      expect(owned_by.count).to eq(2)
      expect(owned_by).to match_array(included)
    end

    it '.filter(current_visitor, "just_mine") should only surface entries owned_by user' do
      just_mine = Entry.filter(@visitor, 'just_mine')
      included = @entries.filtered_vals(:user_ent_1, :user_ent_2)
      expect(just_mine.count).to eq(2)
      expect(just_mine).to match_array(included)
    end

    it '.filter(visitor, "others") only surfaces entries visible but not owned_by user' do
      others = Entry.filter(@visitor, 'others')
      included = @entries.filtered_vals(:publ_orph, :publ_ent)
      expect(others.count).to eq(2)
      expect(others).to match_array(included)
    end

    it '.filter(current_visitor, "xxx") .filter(current_visitor) should surface default' do
      default = Entry.filter(@visitor, 'xxx')
      included = @entries.filtered_vals(:user_ent_1, :user_ent_2, :publ_ent, :publ_orph)
      expect(default.count).to eq(4)
      expect(default).to match_array(included)

      default = Entry.filter(@visitor)
      expect(default.count).to eq(4)
      expect(default).to match_array(included)
    end
  end
end
