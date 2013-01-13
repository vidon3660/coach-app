class AddPlayersProhibitions < ActiveRecord::Migration
  def change
    create_table :players_prohibitions do |t|
      t.references :player
      t.references :prohibition
    end
  end
end
