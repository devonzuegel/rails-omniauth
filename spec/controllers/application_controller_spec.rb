# encoding: utf-8
describe ApplicationController, :omniauth do
  describe '#404:' do
    it 'trying to go to /entry/bad_id should raise an error' do
      expect { get entry_path('bad_id') }.to raise_error ActionController::UrlGenerationError
    end
  end

  describe 'helper methods:' do
    it 'current_user should return nil' do
      expect(current_user).to be nil
    end

    it 'current_user should return current user when signed in' do
      sign_in
      expect(current_user).to eq @user
    end

    it 'current_visitor should create and return current visitor if a new, unique visitor' do
      expect(session[:visitor_id]).to eq nil
      current_visitor
    end

    it 'current_visitor should find and return current visitor if old visitor who is a non-user'
    it 'current_visitor should find and return current visitor if old visitor who is a user'
    it 'current_visitor should return current visitor if signed in'
  end
end
