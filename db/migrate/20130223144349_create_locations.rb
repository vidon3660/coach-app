class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city

      t.integer :place_id

      t.timestamps
    end
  end
end
