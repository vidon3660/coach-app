class CreatePlayerPractises < ActiveRecord::Migration
  def change
    create_table :player_practises do |t|
      t.integer :practise_id
      t.integer :player_id

      t.timestamps
    end
  end
end
