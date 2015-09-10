class RemovePasswordFromPassengers < ActiveRecord::Migration
  def change
    remove_column :passengers, :password
    add_column :passengers, :user_id, :integer
    rename_column :passengers, :name, :first_name
    add_column :passengers, :last_name, :string
    add_index :passengers, :user_id
  end
end
