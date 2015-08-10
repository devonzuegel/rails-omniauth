describe 'entries/freewrite' do
  it 'displays the freewrite page' do
    entry = assign(:entry, build(:entry, body: nil))
    render
    expect(rendered).to have_content entry.title
  end
end
