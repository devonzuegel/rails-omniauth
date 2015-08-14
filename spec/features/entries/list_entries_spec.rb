# encoding: utf-8

# Feature: List entries
#   As a user or visitor
#   When I go to /entries and choose a filter
#   Then I view all entries according to that filter
feature 'List entries by filter', js: true do
  before(:all) { create_dummy_entries }

  feature 'for visitor:' do
    scenario '...' do
      visit entries_path
      expect(page.text).to have_content 'All (3)'
      # expect(page.text).to have_content 'Mine (2)'
      # expect(page.text).to have_content 'Others (1)'
      puts "---------------\n".black + page.text.blue + "\n---------------".black
    end
  end

  feature 'for user:', :omniauth do
    # Scenario: Visitor views public entries + those owned by him
    #   Given I am a visitor
    #   When I visit /entries
    #   Then I initially see all entries visible to me
    # scenario 'visitor can create an entry' do
    #   # ap Entry.all
    #   # sign_in_feature
    #   visit entries_path
    #   puts page.text.blue
    #   puts
    # end
  end
end
