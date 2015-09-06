# encoding: utf-8
require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe 'searching on Entry model:' do
    before(:all) do
      # For some reason, the dummy entries from `describe '/index'` remain.
      # Consolidating into a single search/filter endpoint should make this
      # a moot point for future tests. (TODO)
      Entry.delete_all

      @user    = create(:user)
      @visitor = create(:visitor, user: @user)
      @friend  = create(:user)
      @query   = 'blah'

      # Create one of each entry type with the query as the title.
      each_entry_type(@user, @friend, @visitor)
      Entry.all.each { |e| e.update_attributes(title: @query) }

      # Create one of each entry type without the query as the title..
      each_entry_type(@user, @friend, @visitor)

      # Destroy and recreate indices for all Searchable models.
      recreate_all_indices!
    end

    describe '.es_search' do
      it 'returns all Entry records when no @query is provided' do
        expect(Entry.es_search).to match_array Entry.all
      end

      it 'returns all Entry records when @query is blank' do
        expect(Entry.es_search('    ')).to match_array Entry.all
      end

      it 'searches all Entry records for the @query string' do
        expect(Entry.es_search(@query).count).to eq 6
      end
    end

    describe '.filtered_search' do
      it 'searches filtered Entry records for the @query string ' do
        filtered   = Entry.filter
        es_results = Entry.es_search(@query)

        filtered_search = Entry.filtered_search(query: @query)
        expect(filtered_search).to match_array(filtered & es_results)
      end
    end
  end
end
