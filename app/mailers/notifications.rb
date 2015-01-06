class Notifications < ActionMailer::Base
  default from: 'root@yux.ch'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.invitation.subject
  #
  def invitation(user)
    @user = user

    mail to: user.email
  end
end
