class CreateGroupAttendances < ActiveRecord::Migration
  def change
    create_table :group_attendances do |t|
      t.references :group, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
