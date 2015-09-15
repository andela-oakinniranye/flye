class AddNameColumnToFlights < ActiveRecord::Migration
  def change
    add_column :flights, :name, :string
  end
end
