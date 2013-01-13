class CreateProhibitions < ActiveRecord::Migration
  def change
    create_table :prohibitions do |t|
      t.string :name

      t.timestamps
    end
  end
end
