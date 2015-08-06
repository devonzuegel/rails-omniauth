# app/models/visitor.rb
class Visitor < ActiveRecord::Base
  belongs_to :user
end
