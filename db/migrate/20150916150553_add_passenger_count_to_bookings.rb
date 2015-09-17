class AddPassengerCountToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :passengers_count, :integer
  end
end
