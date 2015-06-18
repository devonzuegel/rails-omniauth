class Account < ActiveRecord::Base
  belongs_to :user

  def self.themes
    %w(light dark)
  end
end