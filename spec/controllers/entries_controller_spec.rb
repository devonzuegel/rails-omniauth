describe EntriesController, :omniauth do
  before(:all) { create_dummy_entries }

  describe '#index' do
    it 'should show filtered entries for a signed-in user' do
      sign_in

      %w(just_mine default others foobar).each do |filter|
        get :index, 'filter' => filter
        expect(response).to render_template(:index)
        current_visitor = @controller.send(:current_visitor)
        expect(assigns(:entries)).to match_array Entry.filter(visitor: current_visitor, filter: filter)
      end
    end

    it 'should show fitlered entries for a visitor' do
      %w(just_mine default others foobar).each do |filter|
        get :index, 'filter' => filter
        expect(response).to render_template(:index)
        current_visitor = nil
        expect(assigns(:entries)).to match_array Entry.filter(visitor: current_visitor, filter: filter)
      end
    end
  end

  describe '#show' do
    it 'should redirect me if I try to view my friends private entry' do
      get :show, id: @entries[:priv_ent].id
      expect(response.body).to have_content 'You are being redirected'
      expect(response).to redirect_to entries_path
    end

    it 'should show me my friends public entry' do
      get :show, id: @entries[:publ_ent].id
      expect(assigns(:entry)).to eq @entries[:publ_ent]
    end

    it 'should redirect me if I try to view an orphaned private entry' do
      get :show, id: @entries[:priv_orph].id
      expect(response.body).to have_content 'You are being redirected'
      expect(response).to redirect_to entries_path
    end

    it 'should show me an orphaned public entry' do
      get :show, id: @entries[:publ_orph].id
      expect(assigns(:entry)).to eq @entries[:publ_orph]
    end

    it 'should show me my own private entry' do
      get :show, id: @entries[:user_ent_2].id
      expect(assigns(:entry)).to eq @entries[:user_ent_2]
    end

    it 'should show me my own public entry' do
      get :show, id: @entries[:user_ent_1].id
      expect(assigns(:entry)).to eq @entries[:user_ent_1]
    end
  end

  describe '#new' do
  end

  describe '#freewrite' do
  end

  describe '#edit' do
  end

  describe '#create' do
  end

  describe '#update' do
  end

  describe '#destroy' do
  end
end
