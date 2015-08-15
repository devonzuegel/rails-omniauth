class Api::V1::EntriesController < Api::ApiController
  def index
    @entries = 'BLAH BLAH BLAH' # Entry.all # TODO: filter!
    respond_with @entries
  end
end
