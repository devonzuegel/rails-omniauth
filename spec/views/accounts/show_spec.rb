describe 'accounts/show' do
  it 'displays the account' do
    assign(:account, create(:account))
    assign(:current_user, create(:user))
    render
    # expect(rendered).to have_link 'Product', href: 'http://example.com'
  end

  it '...'
end
