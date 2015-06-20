describe AccountsController, :omniauth do

  describe "#show" do
    it "should show an account" do 
      sign_in
      get :show
      expect(response.status).to be 200
      expect(response).to render_template(:show)
      expect(assigns(:account)).to match @account
    end

    it "should redirect to root if not logged in" do 
      get :show
      expect(response).to redirect_to root_path
      # TODO: not done ...
    end

    it "more..."
  end

end