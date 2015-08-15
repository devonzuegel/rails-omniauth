class Api::V1::EntriesController < Api::ApiController
  def index
    print 'params: '.black
    ap params
    puts
    @entries = Entry.all # TODO: filter!
    print 'entries: '.black
    ap @entries
    puts
    respond_with @entries
  end
end
