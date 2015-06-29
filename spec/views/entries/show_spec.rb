describe 'entries/show' do
  it 'displays the entry' do
    assign(:entry, create(:entry))
    # assign(:current_user, build(:user))
    render
    # expect(rendered).to have_link 'Product', href: 'http://example.com'
  end

  it '...'
end
