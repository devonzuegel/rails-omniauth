# app/controllers/visitors_controller.rb
class VisitorsController < ApplicationController
  def index
    @entry = Entry.new(visitor: current_visitor, public: current_visitor.public_posts)
  end
end
