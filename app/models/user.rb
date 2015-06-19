class User < ActiveRecord::Base
  has_one :account
  has_many :entries

  validates :name,       length: { minimum: 1 }, allow_nil: true
  validates :first_name, length: { minimum: 1 }, allow_nil: true
  validates :last_name,  length: { minimum: 1 }, allow_nil: true

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name = auth['info']['name']
        user.first_name = auth['info']['first_name']
        user.last_name = auth['info']['last_name']
        user.email = auth['info']['email']
      end

      ap user
    end
  end

end
