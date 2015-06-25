class User < ActiveRecord::Base
  has_many :entries, dependent: :destroy
  has_one  :account, dependent: :destroy
  accepts_nested_attributes_for :account

  validates :account, presence: true
  validates :name,        length: { minimum: 1 }, allow_nil: true
  validates :first_name,  length: { minimum: 1 }, allow_nil: true
  validates :middle_name, length: { minimum: 1 }, allow_nil: true
  validates :last_name,   length: { minimum: 1 }, allow_nil: true

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name        = Utils.non_blank auth['info']['name']
        user.first_name  = Utils.non_blank auth['info']['first_name']
        user.middle_name = Utils.non_blank auth['info']['middle_name']
        user.last_name   = Utils.non_blank auth['info']['last_name']
        user.email       = Utils.non_blank auth['info']['email']
      end
      user.account = Account.new
    end
  end
end
