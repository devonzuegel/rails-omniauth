# app/controllers/api/v1/entries_controller.rb
class Api::V1::EntriesController < Api::ApiController
  def index
    filter = params['filter'] || 'default'
    @entries = Entry.filter(@visitor, filter)
    respond_with :api, :v1, @entries, status: :ok
  end

  def search
    query    = params[:q]
    @entries = Entry.search(query).map { |e| e['_source'] }
    respond_with :api, :v1, @entries, status: :ok
  end
end
