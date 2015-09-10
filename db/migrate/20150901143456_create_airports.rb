class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :name
      t.string :location
      t.string :symbol

      t.timestamps null: false
    end
  end
end
