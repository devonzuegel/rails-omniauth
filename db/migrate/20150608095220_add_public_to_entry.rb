# /db/migrate/20150608095220_add_public_to_entry.rb
class AddPublicToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :public, :boolean, default: false
  end
end
