class CreateEvents < ActiveRecord::Migration
  def change
    drop_table :jobs
    drop_table :workshops
    remove_column :attendances, :workshop_id
    add_column :attendances, :event_id, :integer

    create_table :events do |t|
      t.references :owner, index: true
      t.string :title
      t.string :description
      t.string :meeting_point
      t.datetime :starts
      t.datetime :ends

      t.timestamps
    end
  end
end
