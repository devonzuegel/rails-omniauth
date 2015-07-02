# app/models/account.rb
class Account < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user

  def self.themes
    %w(light dark)
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
    ['(GMT-1:00)  Central African Time', -1]
  ]
end
