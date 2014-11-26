class AddGroupsOnlyToEvents < ActiveRecord::Migration
  def change
    add_column :events, :groups_only, :boolean
  end
end
