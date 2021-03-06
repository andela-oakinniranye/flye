class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.references :origin, index: true
      t.references :destination, index: true
      t.datetime :departure_date
      t.datetime :arrival_date

      t.timestamps null: false
    end
  end
end
