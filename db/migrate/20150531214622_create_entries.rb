# db/migrate/20150531214622_create_entries.rb
class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
