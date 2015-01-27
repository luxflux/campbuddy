class MailPreview < ActionMailer::Preview
  # Pull data from existing fixtures
  def invitation
    Notifications.invitation User.last
  end

  def password_reset
    user = User.last
    user.forgot_password!
    ClearanceMailer.change_password user
  end
end
