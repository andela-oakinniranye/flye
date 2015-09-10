class UpdateColumnPassengerCountsOnFlights < ActiveRecord::Migration
  def change
    change_column :flights, :passenger_count, :integer, default: 0, null: false
  end
end
