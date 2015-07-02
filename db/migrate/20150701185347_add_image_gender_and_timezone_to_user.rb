# ./spec/features/accounts/update_account_spec.rb
class AddImageGenderAndTimezoneToUser < ActiveRecord::Migration
  def change
    add_column :users, :image, :string
    add_column :users, :gender, :string
    add_column :accounts, :timezone, :integer
  end
end
