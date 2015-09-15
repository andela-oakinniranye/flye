class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :booking, index: true
      t.references :passenger, index: true
      t.references :booker, index: true

      t.timestamps null: false
    end
  end
end
