class AddBodyPartsProhibitions < ActiveRecord::Migration
  def change
    create_table :body_parts_prohibitions do |t|
      t.references :body_part
      t.references :prohibition
    end
  end
end
