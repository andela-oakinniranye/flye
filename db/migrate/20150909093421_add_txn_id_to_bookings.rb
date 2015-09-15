class AddTxnIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :txn_id, :string
  end
end
