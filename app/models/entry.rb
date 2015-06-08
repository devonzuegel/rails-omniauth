class Entry < ActiveRecord::Base
  belongs_to :user

  scope :visible, -> (current_user) {
    user_entries = if current_user then current_user.entries else [] end
    public_entries = Entry.where(:public => true)
    entries = user_entries + public_entries
    entries.sort { |a, b| b.created_at - a.created_at }
  }
  
end
