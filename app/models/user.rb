# app/models/user.rb
class User < ActiveRecord::Base
  # RELATIONSHIPS #

  has_many :entries, dependent: :destroy
  has_one :account, dependent: :destroy
  accepts_nested_attributes_for :account

  # VALIDATIONS #

  validates :account, presence: true

  validates_each %i(name first_name middle_name last_name email) do |obj, attribute, val|
    obj.errors.add(attribute, 'many not be empty') if !val.nil? && val.blank?
  end

  # CLASS METHODS #

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.account = Account.new
      user.populate_info(auth)
    end
  end

  # INSTANCE METHODS #

  def populate_info(auth)
    unless auth['info'].nil?
      self.name        = Utils.non_blank(auth['info']['name'])
      self.first_name  = Utils.non_blank(auth['info']['first_name'])
      self.middle_name = Utils.non_blank(auth['info']['middle_name'])
      self.last_name   = Utils.non_blank(auth['info']['last_name'])
      self.email       = Utils.non_blank(auth['info']['email'])
      self.image       = Utils.non_blank(auth['info']['image'])
    end

    unless auth['raw_info'].nil?
      account.timezone  = Utils.non_blank(auth['raw_info']['timezone'])
      self.gender            = Utils.non_blank(auth['raw_info']['gender'])
    end
  end

  def fb_profile_pic(width, height = width)
    width = height = 900 if %i(large lg).include?(width)
    width = height = 500 if %i(medium md).include?(width)
    width = height = 250 if %i(small sm).include?(width)

    "#{image}?width=#{width}&height=#{height}" unless image.nil?
  end
end
