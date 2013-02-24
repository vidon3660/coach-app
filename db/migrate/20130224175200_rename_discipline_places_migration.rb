class RenameDisciplinePlacesMigration < ActiveRecord::Migration
  def change
    rename_table :discipline_places, :place_disciplines
  end
end
