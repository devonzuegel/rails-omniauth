# app/models/user.rb
class User < ActiveRecord::Base
  # RELATIONSHIPS 3

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
      user.populate_info(auth)
      user.account = Account.new
    end
  end

  def self.timezones
    TIMEZONES
  end

  TIMEZONES = [
    ['(GMT)       Greenwich Mean Time', 0],
    ['(GMT)       Universal Coordinated Time', 0],
    ['(GMT+1:00)  European Central Time', +1],
    ['(GMT+2:00)  Eastern European Time', +2],
    ['(GMT+2:00)  Egypt Standard Time', +2],
    ['(GMT+3:00)  Eastern African Time', +3],
    ['(GMT+3:30)  Middle East Time', +3],
    ['(GMT+4:00)  Near East Time', +4],
    ['(GMT+5:00)  Pakistan Lahore Time', +5],
    ['(GMT+5:30)  India Standard Time', +5],
    ['(GMT+6:00)  Bangladesh Standard Time', +6],
    ['(GMT+7:00)  Vietnam Standard Time', +7],
    ['(GMT+8:00)  China Taiwan Time', +8],
    ['(GMT+9:00)  Japan Standard Time', +9],
    ['(GMT+9:30)  Australia Central Time', +9],
    ['(GMT+10:00) Australia Eastern Time', +10],
    ['(GMT+11:00) Solomon Standard Time', +11],
    ['(GMT+12:00) New Zealand Standard Time', +12],
    ['(GMT-11:00) Midway Islands Time', -11],
    ['(GMT-10:00) Hawaii Standard Time', -10],
    ['(GMT-9:00)  Alaska Standard Time', -9],
    ['(GMT-8:00)  Pacific Standard Time', -8],
    ['(GMT-7:00)  Phoenix Standard Time', -7],
    ['(GMT-7:00)  Mountain Standard Time', -7],
    ['(GMT-6:00)  Central Standard Time', -6],
    ['(GMT-5:00)  Eastern Standard Time', -5],
    ['(GMT-5:00)  Indiana Eastern Standard Time', -5],
    ['(GMT-4:00)  Puerto Rico and US Virgin Islands Time', -4],
    ['(GMT-3:30)  Canada Newfoundland Time', -3],
    ['(GMT-3:00)  Argentina Standard Time', -3],
    ['(GMT-3:00)  Brazil Eastern Time', -3],
    ['(GMT-1:00)  Central African Time', -1],
  ]

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
      self.timezone    = Utils.non_blank(auth['raw_info']['timezone'])
      self.gender      = Utils.non_blank(auth['raw_info']['gender'])
    end
  end
end
