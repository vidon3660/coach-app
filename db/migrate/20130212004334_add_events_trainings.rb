class AddEventsTrainings < ActiveRecord::Migration
  def change
    create_table :events_trainings do |t|
      t.integer :event_id
      t.integer :training_id
    end
  end
end
