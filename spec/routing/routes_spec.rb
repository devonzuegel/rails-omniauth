describe "Routes" do
  it "get /" do
    expect(get: root_path).to route_to( controller: "visitors",
                                        action:     "index" )
  end

  # expect(get: create_).to route_to(
  #   :controller => "articles"
  # )

  it "gets all other routes, too"
  it "redirects bad routes to 404"
end