# encoding: utf-8

# Feature: List entries
#   As a user or visitor
#   When I go to /entries and choose a filter
#   Then I view all entries according to that filter
feature 'List entries by filter', js: true do
  before(:all) do
    @user    = create(:user)
    @visitor = create(:visitor, user: @user)
    @friend  = create(:user)
    create_dummy_entries
  end

  feature 'for visitor:' do
    # Scenario: Visitor views public entries + those owned by him
    #   Given I am a visitor
    #   When I visit /entries
    #   Then I initially see all entries visible to me
    scenario '...' do
      visit entries_path
      expect(page.text).to have_content 'All (3)'
      # expect(page.text).to have_content 'Mine (2)'
      # expect(page.text).to have_content 'Others (1)'
      ap @user
      puts "---------------\n".black + page.text.blue + "\n---------------".black
      Entry.labeled_filters.each do |f|
        label, filter = f[:label], f[:filter]
        puts "\n#{label}:".black
        ap Entry.filter(@visitor, filter).map { |e|
          { public: e.public, user_id: e.user_id, visitor_id: e.visitor_id }
        }
      end
      # ap Entry.visible_to(visitor: @visitor)
    end
  end

  feature 'for user:', :omniauth do
    # Scenario: User views public entries + those owned by him
    #   Given I am a user
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
