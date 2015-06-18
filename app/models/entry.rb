class Entry < ActiveRecord::Base
  belongs_to :user
  scope :is_public,  ->        { where(:public => true) }
  scope :visible_to, -> (user) { is_public | where(user: user).where.not(user: nil) }
end
