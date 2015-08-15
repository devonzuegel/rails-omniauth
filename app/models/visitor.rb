# app/models/visitor.rb
class Visitor < ActiveRecord::Base
  include Authenticable
  belongs_to :user
end
