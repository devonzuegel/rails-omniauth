describe 'entries/show' do
  it 'displays the entry' do
    assign(:entry, create(:entry))
    render
    # expect(rendered).to have_link 'Product', href: 'http://example.com'
  end
end
