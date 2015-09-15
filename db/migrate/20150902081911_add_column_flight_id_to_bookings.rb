class AddColumnFlightIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :flight_id, :integer
  end
end
