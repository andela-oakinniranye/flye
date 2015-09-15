class RemovePriceFromBookingAddPriceToFlight < ActiveRecord::Migration
  def change
    remove_column :bookings, :booking_price
    add_column :flights, :price, :integer, default: 0, null: false
  end
end
