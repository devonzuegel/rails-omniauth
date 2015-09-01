# encoding: utf-8

# Feature: Delete entry from /entries page
feature 'Delete entry from /entries page', js: true do
  before(:each) do
    create_dummy_entries
  end

  feature 'for visitor:' do
    before do
      @non_user_visitor = create(:visitor, user: nil)
      @entry = create(:entry, visitor: @non_user_visitor)

      allow_any_instance_of(EntriesController)
        .to receive(:current_visitor).and_return(@non_user_visitor)
    end
    # Scenario: Given I am a visitor without an account
    #   When I see an entry that I created
    #   And I click the 'X' button to delete it
    #   That entry is removed from the page
    scenario 'visitor can delete an entry'
    # do
    #   visit entries_path
    #   expect(page.text).to have_content 'All (4)'
    #   click "delete-entry-#{@entry.id}"
    #   # TODO: accept the action in the popup
    #   expect(page.text).to have_content 'All (3)'
    # end
  end

  feature 'for user:', :omniauth do
    scenario 'registered user can delete an entry'
  end
end
