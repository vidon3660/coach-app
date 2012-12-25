class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.integer :height
      t.integer :weight
      t.integer :user_id

      t.timestamps
    end
  end
end
