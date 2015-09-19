class AddInviteMailToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :invitation_mail, :text
  end
end
