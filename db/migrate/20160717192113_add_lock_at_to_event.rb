class AddLockAtToEvent < ActiveRecord::Migration
  def change
    add_column :events, :lock_at, :datetime, default: nil
  end
end
