# db/migrate/20150619042138_add_email_and_name_to_user.rb
class AddEmailAndNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :last_name, :string
  end
end
