# app/models/user.rb
class User < ActiveRecord::Base
  has_many :entries, dependent: :destroy
  has_one :account, dependent: :destroy
  accepts_nested_attributes_for :account

  validates :account, presence: true

  validates_each %i(name first_name middle_name last_name email) do |obj, attribute, val|
    obj.errors.add(attribute, 'many not be empty') if !val.nil? && val.blank?
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.populate_info(auth['info'])
      user.account = Account.new
    end
  end

  def populate_info(info)
    return if info.nil?
    self.name        = Utils.non_blank(info['name'])
    self.first_name  = Utils.non_blank(info['first_name'])
    self.middle_name = Utils.non_blank(info['middle_name'])
    self.last_name   = Utils.non_blank(info['last_name'])
    self.email       = Utils.non_blank(info['email'])
  end
end
