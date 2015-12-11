class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.string :address
      t.float :gas_price
      t.float :etanol_price
      t.float :diesel_price
      t.json :coordinate
      t.float :rate

      t.timestamps null: false
    end
  end
end
