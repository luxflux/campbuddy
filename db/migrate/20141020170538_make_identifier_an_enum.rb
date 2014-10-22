class MakeIdentifierAnEnum < ActiveRecord::Migration
  def change
    remove_column :categories, :identifier
    add_column :categories, :identifier, :integer
  end
end
