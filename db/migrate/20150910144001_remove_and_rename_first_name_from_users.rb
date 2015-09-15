class RemoveAndRenameFirstNameFromUsers < ActiveRecord::Migration
  def change
    rename_column :users, :first_name, :name
    remove_column :users, :password, :string
    remove_column :users, :last_name, :string
    add_column :users, :profile_url, :string
    add_column :users, :auth_token, :string
    add_column :users, :oauth_token_expires_at, :datetime
  end
end
