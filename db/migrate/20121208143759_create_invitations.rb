class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :inviting_id
      t.integer :invited_id

      t.timestamps
    end
  end
end
