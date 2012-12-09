class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :contact_id
      t.boolean :training

      t.timestamps
    end
  end
end
