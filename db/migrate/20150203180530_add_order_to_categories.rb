class AddOrderToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :order, :integer
  end
end
