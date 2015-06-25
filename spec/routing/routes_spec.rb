describe "Routes" do
  it "get /" do
    expect(get: root_path).to route_to({ controller: "visitors", action: "index" })
  end

  it "get /"
  # expect(get: create_).to route_to(
  #   :controller => "articles"
  # )

  it "gets all other routes, too"
  it "redirects bad routes to 404"


=begin 
         Prefix Verb   URI Pattern                        Controller#Action
-----------------------------------------------------------------------------------
        account POST   /account(.:format)                 accounts#create
    new_account GET    /account/new(.:format)             accounts#new
   edit_account GET    /account/edit(.:format)            accounts#edit
                GET    /account(.:format)                 accounts#show
                PATCH  /account(.:format)                 accounts#update
                PUT    /account(.:format)                 accounts#update
                DELETE /account(.:format)                 accounts#destroy
freewrite_entry GET    /entries/:id/freewrite(.:format)   entries#freewrite
        entries GET    /entries(.:format)                 entries#index
                POST   /entries(.:format)                 entries#create
      new_entry GET    /entries/new(.:format)             entries#new
     edit_entry GET    /entries/:id/edit(.:format)        entries#edit
          entry GET    /entries/:id(.:format)             entries#show
                PATCH  /entries/:id(.:format)             entries#update
                PUT    /entries/:id(.:format)             entries#update
                DELETE /entries/:id(.:format)             entries#destroy
           root GET    /                                  visitors#index
                GET    /auth/:provider/callback(.:format) sessions#create
         signin GET    /signin(.:format)                  sessions#new
        signout GET    /signout(.:format)                 sessions#destroy
   auth_failure GET    /auth/failure(.:format)            sessions#failure
           page GET    /pages/*id                         high_voltage/pages#show
-----------------------------------------------------------------------------------
=end
end