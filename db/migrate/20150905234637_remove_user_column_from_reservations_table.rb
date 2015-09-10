class RemoveUserColumnFromReservationsTable < ActiveRecord::Migration
  def change
    remove_column :reservations, :user_id
    add_column :bookings, :user_id, :integer
  end
end
