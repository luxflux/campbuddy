class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string :name
      t.text :description
      t.string :map
      t.integer :order

      t.timestamps null: false
    end
  end
end
