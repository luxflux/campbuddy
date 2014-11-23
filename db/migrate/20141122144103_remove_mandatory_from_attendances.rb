class RemoveMandatoryFromAttendances < ActiveRecord::Migration
  def up
    remove_column :attendances, :mandatory
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
