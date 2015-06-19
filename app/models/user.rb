class User < ActiveRecord::Base
  has_one :account
  accepts_nested_attributes_for :account
  has_many :entries

  validates :name,        length: { minimum: 1 }, allow_nil: true
  validates :first_name,  length: { minimum: 1 }, allow_nil: true
  validates :middle_name, length: { minimum: 1 }, allow_nil: true
  validates :last_name,   length: { minimum: 1 }, allow_nil: true

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name        = non_blank auth['info']['name']
        user.first_name  = non_blank auth['info']['first_name']
        user.middle_name = non_blank auth['info']['middle_name']
        user.last_name   = non_blank auth['info']['last_name']
        user.email       = non_blank auth['info']['email']
      end
    end
  end
end
