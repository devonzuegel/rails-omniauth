describe "Routes" do
  it "check that paths route to expected controller-action" do
    expect(get: root_path).to route_to          'visitors#index'
    expect(get: account_path).to route_to       'accounts#show'
    expect(get: entry_path(1)).to route_to      'entries#show', id: "1"
    expect(get: new_entry_path).to route_to     'entries#new'
    expect(get: edit_entry_path(1)).to route_to 'entries#edit', id: "1"
    expect(get: signin_path).to route_to        'sessions#new'
    expect(get: signout_path).to route_to       'sessions#destroy'
  end

  it "/account/new shouldn't actually exist" do
    expect(get: '/account/new').to_not be_routable
  end
end