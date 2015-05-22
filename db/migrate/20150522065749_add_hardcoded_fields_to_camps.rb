class AddHardcodedFieldsToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :hashtag, :string
    add_column :camps, :starts, :date
    add_column :camps, :ends, :date
    add_column :camps, :registration_opens, :datetime
  end
end
