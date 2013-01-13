class CreateTraineds < ActiveRecord::Migration
  def change
    create_table :traineds do |t|
      t.integer :coach_id
      t.integer :trained_id

      t.timestamps
    end
  end
end
