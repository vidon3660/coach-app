class CreatePlayerProhibitions < ActiveRecord::Migration
  def change
    create_table :player_prohibitions do |t|
      t.integer :player_id
      t.integer :prohibition_id

      t.timestamps
    end
  end
end
