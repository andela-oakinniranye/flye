class AddStatusToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :status, :integer, default: 0, null: false
  end
end
