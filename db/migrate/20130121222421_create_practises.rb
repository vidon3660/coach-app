class CreatePractises < ActiveRecord::Migration
  def change
    create_table :practises do |t|
      t.string :name

      t.timestamps
    end
  end
end
