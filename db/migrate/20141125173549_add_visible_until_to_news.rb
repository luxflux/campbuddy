class AddVisibleUntilToNews < ActiveRecord::Migration
  def change
    add_column :news, :visible_until, :datetime
  end
end
