describe EntriesController, :omniauth do
  def create_dummy_entries
    @friend = create(:user)

    @entries = {
      user_ent_1: create(:entry, user: @user, public: true),
      user_ent_2: create(:entry, user: @user, public: false),
      publ_orph:  create(:entry, user: nil, public: true),
      priv_orph:  create(:entry, user: nil, public: false),
      publ_ent:   create(:entry, user: @friend, public: true),
      priv_ent:   create(:entry, user: @friend, public: false)
    }
  end

  describe '#index' do
    it 'should show entries filtered by just_mine, default, others, and foobar (default) for a signed-in user' do
      sign_in
      create_dummy_entries

      %w(just_mine default others foobar).each do |filter|
        get :index, 'filter' => filter
        expect(response).to render_template(:index)
        expect(assigns(:entries)).to match_array Entry.filter(@user, filter)
      end
    end

    it 'should show entries filtered by just_mine and default for a visitor'
    it 'should show entries filtered by Entry.filter(current_user, "default")'
    it 'should show entries filtered by Entry.filtered(current_user, "just_mine")'
    it 'should show entries filtered by Entry.filtered(current_user, "others")'
  end

  describe '#show' do
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
