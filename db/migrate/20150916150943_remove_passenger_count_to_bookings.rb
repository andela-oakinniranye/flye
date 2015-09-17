class RemovePassengerCountToBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :passengers_count, :integer
    add_column :bookings, :passengers_count, :integer, default: 0
  end
end
