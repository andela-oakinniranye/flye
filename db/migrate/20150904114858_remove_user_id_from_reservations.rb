class RemoveUserIdFromReservations < ActiveRecord::Migration
  def change
    remove_column :reservations, :user_id
  end
end
