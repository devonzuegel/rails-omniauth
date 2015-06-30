# encoding: utf-8
describe ApplicationController, :omniauth do
  describe '#404' do
    it 'trying to go to /entry/bad_id should raise an error' do
      expect do
        get entry_path('bad_id')
      end.to raise_error ActionController::UrlGenerationError
    end
  end
end
