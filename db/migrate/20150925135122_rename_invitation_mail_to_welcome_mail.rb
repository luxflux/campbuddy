class RenameInvitationMailToWelcomeMail < ActiveRecord::Migration
  def change
    rename_column :camps, :invitation_mail, :welcome_mail
  end
end
