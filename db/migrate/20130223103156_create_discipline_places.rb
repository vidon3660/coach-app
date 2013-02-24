class CreateDisciplinePlaces < ActiveRecord::Migration
  def change
    create_table :discipline_places do |t|
      t.text :description

      t.integer :discipline_id
      t.integer :place_id

      t.timestamps
    end
  end
end
