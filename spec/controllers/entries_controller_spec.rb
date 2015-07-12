describe EntriesController, :omniauth do
  describe '#index' do
    it 'should show entries filtered by just_mine, default, others, and foobar (default) for a **signed-in user**' do
      sign_in
      create_dummy_entries

      ap session

      %w(just_mine default others foobar).each do |filter|
        get :index, 'filter' => filter
        expect(response).to render_template(:index)
        expect(assigns(:entries)).to match_array Entry.filter(@user, filter)
      end
    end

    it 'should show entries filtered by just_mine and default for a **visitor**' do
      create_dummy_entries

      %w(just_mine default others foobar).each do |filter|
        get :index, 'filter' => filter
        expect(response).to render_template(:index)
        expect(assigns(:entries)).to match_array Entry.filter(@user = nil, filter)
      end
    end
  end

  describe '#show' do
    before(:all) { create_dummy_entries }

    it 'should redirect me if I try to view my friends private entry' do
      get :show, id: @entries[:priv_ent].id
      expect(response.body).to have_content 'You are being redirected'
      expect(response).to redirect_to entries_path
    end

    it 'should show me my friends public entry' do
      get :show, id: @entries[:publ_ent].id
      expect(assigns(:entry)).to eq @entries[:publ_ent]
    end

    it 'should redirect me if I try to view an orphaned private entry'
    # do
    #   get :show, id: @entries[:priv_orph].id
    #   expect(response.body).to have_content 'You are being redirected'
    #   expect(response).to redirect_to entries_path
    # end

    it 'should show me an orphaned public entry' do
      get :show, id: @entries[:publ_orph].id
      expect(assigns(:entry)).to eq @entries[:publ_orph]
    end

    it 'should show me my own private entry'
    it 'should show me my own public entry'
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
