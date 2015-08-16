# db/migrate/20150814234359_add_api_key_to_user.rb
class AddApiKeyToUser < ActiveRecord::Migration
  def change
    add_column :visitors, :api_key, :string
  end
end
