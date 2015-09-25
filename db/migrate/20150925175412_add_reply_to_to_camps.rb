class AddReplyToToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :reply_to, :string
  end
end
