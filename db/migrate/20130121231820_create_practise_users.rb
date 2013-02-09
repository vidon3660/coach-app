class CreatePractiseUsers < ActiveRecord::Migration
  def change
    create_table :practise_users do |t|
      t.integer :practise_id
      t.integer :user_id

      t.timestamps
    end
  end
end
