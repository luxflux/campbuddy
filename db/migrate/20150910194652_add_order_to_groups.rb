class AddOrderToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :order, :integer, index: true
  end
end
