class AddCloseAtToTrainings < ActiveRecord::Migration
  def change
    add_column :trainings, :close_at, :datetime
  end
end
