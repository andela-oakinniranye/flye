class AddPassengerCountToFlightTable < ActiveRecord::Migration
  def change
    add_column :flights, :passenger_count, :integer
  end
end
