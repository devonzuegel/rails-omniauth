# app/controllers/api/v1/entries_controller.rb
class Api::V1::EntriesController < Api::ApiController
  def index
    filter   = params['filter'] || 'default'
    query    = params['query'] || nil
    @entries = Entry.filtered_search(query: query, visitor: @visitor, filter: filter)
    respond_with :api, :v1, @entries, status: :ok
  end
end
