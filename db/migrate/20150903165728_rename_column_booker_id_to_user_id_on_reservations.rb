class RenameColumnBookerIdToUserIdOnReservations < ActiveRecord::Migration
  def change
    rename_column :reservations, :booker_id, :user_id
  end
end
