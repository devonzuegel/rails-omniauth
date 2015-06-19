describe "Routes" do
  it "get /" do
    expect(get: root_path).to route_to( controller: "visitors",
                                        action:     "index" )
  end
end