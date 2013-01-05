class ChangeColumns < ActiveRecord::Migration
  def up
    remove_column :users, :address
    remove_column :users, :birth
    remove_column :users, :country
    remove_column :users, :city
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :phone

    remove_column :parameters, :user_id
    add_column :parameters, :player_id, :integer

    remove_column :users, :delta
    add_column :players, :delta, :boolean, default: true, null: false  	
  end

  def down
    add_column :users, :address, :string
    add_column :users, :birth, :date
    add_column :users, :country, :string
    add_column :users, :city, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string

    add_column :parameters, :user_id, :integer
    remove_column :parameters, :player_id

    add_column :users, :delta, :boolean, default: true, null: false
    remove_column :players, :delta
  end
end