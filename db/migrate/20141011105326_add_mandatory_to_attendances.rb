class AddMandatoryToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :mandatory, :boolean
  end
end
