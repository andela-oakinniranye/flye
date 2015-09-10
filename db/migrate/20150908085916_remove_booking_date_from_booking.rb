class RemoveBookingDateFromBooking < ActiveRecord::Migration
  def change
    remove_column :bookings, :booking_date
  end
end
