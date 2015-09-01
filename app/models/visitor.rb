# app/models/visitor.rb
class Visitor < ActiveRecord::Base
  include Authenticable
  belongs_to :user

  ##
  # Usage: visitor.public_posts
  # ---
  # If the visitor is not a registered user, make posts private by default.
  # Otherwise, refer to the account settings.
  ##
  def public_posts
    user.present? ? user.account.public_posts : false
  end
end
