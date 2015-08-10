describe 'entries/show' do
  it 'displays the entry'do
    @entry = assign(:entry, create(:entry))
    render
    expect(rendered).to have_content(@entry.title)
    expect(rendered).to have_content(@entry.body)
  end
end
