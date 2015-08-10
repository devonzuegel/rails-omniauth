# encoding: utf-8

# Feature: Create new entry from home page
# As a visitor
# I want to create and save an entry
feature 'Create new entry from home page', :omniauth do
  before do
    @entry_data = {
      title: 'MyTitle',
      body: 'This is the body.'
    }
  end

  # Scenario: Visitor can create an entry
  # Given I am a visitor
  # When I enter a title and click "Start writing"
  # Then I go to the freewrite page
  scenario 'visitor can create an entry' do
    create_valid_entry
  end

  # Scenario: User can create an entry
  # Given I am a user
  # When I enter a title and click "Start writing"
  # Then I go to the freewrite page
  scenario 'signed-in user can create an entry' do
    sign_in_feature
    create_valid_entry
  end

  # Scenario: Entry can't have a blank title
  # Given I am a visitor
  # When I don't enter a title and click "Start writing"
  # Then I get an error message telling me that the title can't be blank
  scenario "entry can't have a blank title" do
    visit root_path
    fill_in 'entry_title', with: '    '
    click_button 'Start writing'
    expect(page).to have_content("Title can't be blank")
    path_should_be root_path
  end

  scenario 'user can delete entry'
end

## HELPER METHODS ##

def create_valid_entry
  visit root_path
  fill_in 'entry[title]', with: @entry_data[:title]
  click_button 'Start writing'
  expect(page.body).to include(@entry_data[:title])
  path_should_be(%r{^\/entries\/\d+\/freewrite$})
end
