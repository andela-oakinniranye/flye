class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :passenger, index: true, foreign_key: true
      t.datetime :booking_date
      t.integer :booking_price

      t.timestamps null: false
    end
  end
end
