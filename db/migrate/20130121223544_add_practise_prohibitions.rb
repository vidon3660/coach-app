class AddPractiseProhibitions < ActiveRecord::Migration
  def change
    create_table :practises_prohibitions do |t|
      t.integer :practise_id
      t.integer :prohibition_id
    end
  end
end
