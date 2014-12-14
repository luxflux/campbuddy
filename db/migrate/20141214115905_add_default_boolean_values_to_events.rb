class AddDefaultBooleanValuesToEvents < ActiveRecord::Migration
  def up
    change_column :events, :mandatory, :boolean, default: false
    change_column :events, :groups_only, :boolean, default: false

    Event.where(mandatory: nil).each do |event|
      event.update_attributes(mandatory: false)
    end
    Event.where(groups_only: nil).each do |event|
      event.update_attributes(groups_only: false)
    end
  end

  def down
    change_column :events, :billed, :boolean, default: nil
    change_column :events, :locked, :boolean, default: nil
  end
end
