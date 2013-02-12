class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.string :type
      t.string :description

      t.timestamps
    end
  end
end
