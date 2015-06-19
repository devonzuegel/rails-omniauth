class User < ActiveRecord::Base
  has_one :account
  accepts_nested_attributes_for :account
  has_many :entries

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end

end
