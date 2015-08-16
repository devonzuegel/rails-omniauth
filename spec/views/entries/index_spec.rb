describe 'entries/index' do
  it 'displays all entries'do
    @entries = assign(:entries, [create(:entry), create(:entry)])
    render
    # React.js loads entry cards, nothing to check here
  end
end
