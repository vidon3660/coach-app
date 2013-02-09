class CreateProhibitionUsers < ActiveRecord::Migration
  def change
    create_table :prohibition_users do |t|
      t.integer :prohibition_id
      t.integer :user_id

      t.timestamps
    end
  end
end
