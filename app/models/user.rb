class User < ActiveRecord::Base
  has_one :account
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
        user.name        = (auth['info']['name']        || "").non_blank
        user.first_name  = (auth['info']['first_name']  || "").non_blank
        user.middle_name = (auth['info']['middle_name'] || "").non_blank
        user.last_name   = (auth['info']['last_name']   || "").non_blank
        user.email       = (auth['info']['email']       || "").non_blank
      end

      # ap user
    end
  end
end
