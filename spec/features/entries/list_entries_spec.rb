# encoding: utf-8

# Feature: List entries
#   As a user or visitor
#   When I go to /entries and choose a filter
#   Then I view all entries according to that filter
feature 'List entries by filter', js: true do
  before(:each) { create_dummy_entries }

  feature 'for visitor:' do
    before(:each) do
      @non_user_visitor = create(:visitor, user: nil)
      allow_any_instance_of(EntriesController)
        .to receive(:current_visitor).and_return(@non_user_visitor)
    end

    # Scenario: Visitor views public entries + those owned by him
    #   Given I am a visitor
    #   When I visit /entries
    #   Then I initially see all entries visible to me
    #   And when I click each filter I see the relevant filtered entries
    scenario 'list filtered entries' do
      visit entries_path

      expect(page.text).to have_content 'All (3)'
      expect(page.text).to have_content 'Mine (0)'
      expect(page.text).to have_content 'Others (3)'

      Entry.filters.each do |filter|
        page.find_by_id("#{filter}-filter").click
        Entry.filter(visitor: @non_user_visitor, filter: filter).each do |entry|
          expect(page).to have_content(entry.title)
          expect(page).to have_content(entry.body)
        end
      end
    end
  end

  feature 'for user:', :omniauth do
    before(:each) do
      allow_any_instance_of(EntriesController)
        .to receive(:current_visitor)
        .and_return(@visitor)
    end

    # Scenario: User views public entries + those owned by him
    #   Given I am a user
    #   When I visit /entries
    #   Then I initially see all entries visible to me
    #   And when I click each filter I see the relevant filtered entries
    scenario 'list filtered entries' do
      visit entries_path

      expect(page.text).to have_content 'All (4)'
      expect(page.text).to have_content 'Mine (2)'
      expect(page.text).to have_content 'Others (2)'

      Entry.filters.each do |filter|
        page.find_by_id("#{filter}-filter").click
        Entry.filter(visitor: @visitor, filter: filter).each do |entry|
          expect(page).to have_content(entry.title)
          expect(page).to have_content(entry.body)
        end
      end
    end
  end
end
