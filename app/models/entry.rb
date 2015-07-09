# app/models/entry.rb
class Entry < ActiveRecord::Base
  belongs_to :user
  scope :is_public,  -> ()     { where(:public => true) }
  scope :owned_by,   -> (user) { where(user: user).where.not(user: nil) }
  scope :visible_to, -> (user) { is_public | owned_by(user) }

  validates :title, presence: true, allow_blank: false


  def self.filter(user, filter = 'default')
    case filter
      when 'just_mine' then owned_by(user)
      when 'others'    then visible_to(user) - owned_by(user)
      else             visible_to(user)
    end
  end

end
