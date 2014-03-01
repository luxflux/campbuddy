class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.references :owner, index: true
      t.datetime :starts
      t.datetime :ends
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
