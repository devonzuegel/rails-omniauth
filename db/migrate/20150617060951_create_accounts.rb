# db/migrate/20150617060951_create_accounts.rb
class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :theme, default: 'light'
      t.boolean :public_posts, default: false
      t.references :user
      t.timestamps null: false
    end

    add_index :accounts, :user_id
  end
end
