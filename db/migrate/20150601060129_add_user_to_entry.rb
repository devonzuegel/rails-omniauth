# db/migrate/20150601060129_add_user_to_entry.rb
class AddUserToEntry < ActiveRecord::Migration
  def change
    add_reference :entries, :user, index: true, foreign_key: true
  end
end
