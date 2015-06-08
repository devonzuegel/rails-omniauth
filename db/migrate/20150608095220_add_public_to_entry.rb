class AddPublicToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :public, :boolean
  end
end
