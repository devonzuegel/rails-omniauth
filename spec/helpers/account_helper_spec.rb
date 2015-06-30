# encoding: utf-8
require 'rails_helper'

describe AccountHelper, :omniauth do
  describe '#theme' do
    it 'return default theme' do
      sign_in
      expect(helper.theme).to match 'light'
    end

    it "return user's theme when updated" do
      sign_in
      expect(helper.theme).to match 'light'
      current_user.account.update(theme: 'dark')
      expect(helper.theme).to match 'dark'
    end
  end
end
