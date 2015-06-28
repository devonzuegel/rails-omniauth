class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :theme, default: 'light'
      t.boolean :public_posts, default: false
      t.references :user
      t.timestamps null: false
    end
  end
end
