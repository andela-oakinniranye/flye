class AddBookerIdToBookingsTable < ActiveRecord::Migration
  def change
    add_column :bookings, :booker_id, :integer
    add_index :bookings, :booker_id
  end
end
