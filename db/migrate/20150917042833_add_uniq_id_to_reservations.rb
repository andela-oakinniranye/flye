class AddUniqIdToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :uniq_id, :string
  end
end
