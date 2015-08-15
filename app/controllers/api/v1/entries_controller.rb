class Api::V1::EntriesController < Api::ApiController
  respond_to :json

  def index
    @entries = Entry.all # TODO: filter!
    respond_with @entries
  end
end
