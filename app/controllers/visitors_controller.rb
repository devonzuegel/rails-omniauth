# app/controllers/visitors_controller.rb
class VisitorsController < ApplicationController
  def index
    @entry = Entry.new
  end
end
