class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.text :description
      t.datetime :starts
      t.datetime :ends
      t.references :group, index: true

      t.timestamps
    end
  end
end
