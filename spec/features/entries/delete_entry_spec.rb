# encoding: utf-8

# Feature: Create new entry from home page
# As a visitor
# I want to create and save an entry
feature 'Delete entry from /entries page', :omniauth do
  # Scenario: Visitor can create an entry
  # Given I am a visitor
  # When I enter a title and click "Start writing"
  # Then I go to the freewrite page
  scenario 'visitor can delete an entry'
  # do
  #   create_valid_entry
  #   visit entries_path
  #   sleep 2
  #   ap Entry.all
  #   puts page.text.red
  # end
end
