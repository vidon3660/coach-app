class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :address
      t.date :birth
      t.string :country
      t.string :city
      t.string :first_name
      t.string :last_name
      t.string :phone

      t.integer :user_id

      t.timestamps
    end
  end
end
