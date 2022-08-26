class CreateFlights < ActiveRecord::Migration[7.0]
  def change
    create_table :flights do |t|
      t.datetime :departure_time
      t.references :airline, null: false, foreign_key: true

      t.timestamps
    end
  end
end
