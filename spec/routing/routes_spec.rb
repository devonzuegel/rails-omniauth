describe "Routes" do
  it "get /" do
    expect(get: root_path).to route_to( controller: "visitors",
                                        action:     "index" )
  end

  it "gets all other routes, too"
  it "redirects bad routes to 404"
end