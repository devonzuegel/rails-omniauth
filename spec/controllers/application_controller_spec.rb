# encoding: utf-8
describe ApplicationController, :omniauth do
  describe '#404:' do
    it 'trying to go to /entry/bad_id should raise an error' do
      expect { get entry_path('bad_id') }.to raise_error ActionController::UrlGenerationError
    end
  end

  describe 'helper methods:' do
    describe 'correct_user!' do
      it 'should return false when not signed in'
      it 'should return false when a different user'
      it 'should return true signed in as user'
    end

    describe 'authenticate_user!' do
      it 'should redirect me to the root url to sign in if not signed in'
    end

    describe 'current_user' do
      it 'should return nil when not signed in' do
        expect(@controller.send(:current_user)).to be nil
      end

      it 'should return current user when signed in' do
        sign_in
        expect(@controller.send(:current_user)).to eq @user
      end
    end

    describe 'current_visitor' do
      it 'should create and return current visitor if a new, unique visitor' do
        expect(session[:visitor_id]).to eq nil
        visitor = @controller.send(:current_visitor)
        expect(session[:visitor_id]).to eq visitor.id
        expect(visitor.ip_address).to eq request.remote_ip
        expect(visitor.user).to eq nil
      end

      it 'should find and return current visitor if old visitor who is a non-user' do
        visitor = @controller.send(:log_visitor)
        expect(@controller.send(:current_visitor)).to eq(visitor)

        session = {}  # Clear session

        @controller.send(:log_visitor)
        expect(@controller.send(:current_visitor)).to eq(visitor)
      end

      it 'should find and return current visitor if old visitor who is a user'
      it 'should return current visitor if signed in'
    end

    describe 'log_visitor' do
      it 'should keep an accurate view_count' do
        expect do
          @controller.send(:log_visitor)
        end.to change {
          @controller.send(:current_visitor).view_count
        }.by 1
      end
    end

    describe 'visitor_logged?' do
      it 'should be false before log_visitor and true after' do
        expect(@controller.send :visitor_logged?).to eq false
        @controller.send(:log_visitor)
        expect(@controller.send :visitor_logged?).to eq true
      end
    end

    describe 'returning_visitor?' do
      it 'should be false before log_visitor and true after, even after clearing session' do
        expect(@controller.send :returning_visitor?).to eq false
        @controller.send(:log_visitor)
        expect(@controller.send :returning_visitor?).to eq true
      end
    end

    describe 'signed_in?' do
    end
  end
end
