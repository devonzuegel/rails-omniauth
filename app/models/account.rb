class Account < ActiveRecord::Base
  belongs_to :user

  def self.themes
    ["light", "dark"]
  end
end