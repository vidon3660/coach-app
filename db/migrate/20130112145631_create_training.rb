class CreateTraining < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.integer :coach_id
      t.integer :user_id

      t.timestamps
    end
  end
end
