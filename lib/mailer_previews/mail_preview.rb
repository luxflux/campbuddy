class MailPreview < ActionMailer::Preview
  # Pull data from existing fixtures
  def invitation
    Notifications.invitation User.last
  end
end
