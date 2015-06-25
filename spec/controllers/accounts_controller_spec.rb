describe AccountsController, :omniauth do

  describe "#show" do
    it "should show an account" do 
      sign_in
      get :show
      expect(response.status).to be 200
      expect(response).to render_template(:show)

      # Ensure that the controller @account matches the test
      # @account we created here.
      expect(assigns(:account)).to match @user.account
    end

    it "should redirect to root if not logged in" do 
      get :show
      expect(response).to redirect_to root_path
      expect(response.body).to have_content "You are being redirected"
    end
  end

  describe "#update" do
    it "should update the account successfully" do
      sign_in
      post :update, {
        account:         { account:    @account },
        user_attributes: { first_name: "DEVON" }
      }
# {
#      "public_posts" => "false",
#             "theme" => "light",
#   "user_attributes" => {
#     "first_name" => "mock",
#             "id" => "1",
#      "last_name" => "user"
#   }
# }
      expect(response).to redirect_to account_path
      # ap @user
    end

    it "should fail on updating the account"
  end

end