class Notifications < ActionMailer::Base
  default from: 'buddy@oneyouth.ch'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.invitation.subject
  #
  def invitation(user, camp)
    @user = user
    @camp = camp
    @text = @camp.invitation_mail

    mail to: user.email, subject: "#{@camp.name} | #{I18n.t('notifications.invitation.subject')}"
  end
end
