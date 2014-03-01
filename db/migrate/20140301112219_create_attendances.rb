class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :user
      t.references :workshop

      t.timestamps
    end

    add_index :attendances, [:user_id, :workshop_id], unique: true

  end
end
