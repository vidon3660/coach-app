class AddStatusAndPhoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :string
    add_column :users, :phone, :string
  end
end
