class AddInfoEventsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :info_events, :boolean, default: false
  end
end
