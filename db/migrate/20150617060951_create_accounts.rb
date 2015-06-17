class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :theme
      t.boolean :public_posts
      t.references :user
      t.timestamps null: false
    end
  end
end
