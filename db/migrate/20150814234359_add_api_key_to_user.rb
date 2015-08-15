class AddApiKeyToUser < ActiveRecord::Migration
  def change
    add_column :visitors, :api_key, :string
  end
end
