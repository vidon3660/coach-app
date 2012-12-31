class AddTrainingToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :training, :boolean
  end
end
