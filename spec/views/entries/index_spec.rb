describe 'entries/index' do
  it 'displays all entries'do
    @entries = assign(:entries, [create(:entry), create(:entry)])
    render
    expect(rendered).to have_content 'Entries'  # React.js loads entry cards
  end
end
