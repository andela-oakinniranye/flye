class RemoveColumnBookerIdFromBookingTable < ActiveRecord::Migration
  def change
    remove_column :bookings, :booker_id
  end
end
