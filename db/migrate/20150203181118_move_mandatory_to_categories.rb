class MoveMandatoryToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :mandatory_events, :boolean, default: false

    remove_column :events, :mandatory
  end
end
