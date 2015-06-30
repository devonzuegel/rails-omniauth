# app/models/account.rb
class Account < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user

  def self.themes
    %w(light dark)
  end
end
