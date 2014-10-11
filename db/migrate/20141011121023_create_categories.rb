class CreateCategories < ActiveRecord::Migration
  def change
    add_column :events, :category_id, :integer, index: true

    create_table :categories do |t|
      t.string :name
      t.string :identifier

      t.timestamps
    end
  end
end
