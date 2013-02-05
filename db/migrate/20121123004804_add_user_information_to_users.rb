class AddUserInformationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :birth, :date
    add_column :users, :country, :string
    add_column :users, :city, :string
    add_column :users, :status, :string
    add_column :users, :phone, :string
    add_column :users, :coach, :boolean
  end
end
