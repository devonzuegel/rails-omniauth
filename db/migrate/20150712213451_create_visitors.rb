# db/migrate/20150712213451_create_visitors.rb
class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string :ip_address
      t.references :user, index: true, foreign_key: true
      t.integer :view_count, default: 0

      t.timestamps null: false
    end
  end
end
