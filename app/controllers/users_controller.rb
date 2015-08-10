# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!
end
