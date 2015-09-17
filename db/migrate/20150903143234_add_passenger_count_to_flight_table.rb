class AddPassengerCountToFlightTable < ActiveRecord::Migration
  def change
    add_column :flights, :passengers_count, :integer, default: 0
  end
end
