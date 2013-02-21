class CreateUserDisciplines < ActiveRecord::Migration
  def change
    create_table :user_disciplines do |t|
      t.boolean :is_coach

      t.integer :discipline_id
      t.integer :user_id

      t.timestamps
    end
  end
end
