class Notifications < ActionMailer::Base
  default from: 'buddy@campbuddy.ch'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.welcome.subject
  #
  def welcome(user, camp)
    @user = user
    @camp = camp
    @text = @camp.welcome_mail

    mail to: user.email,
         reply_to: @camp.reply_to,
         subject: "#{@camp.name} | #{I18n.t('notifications.welcome.subject')}",
         track_opens: true
  end
end
