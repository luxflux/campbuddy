module NotificationsHelper
  def replace_variables(text)
    text.
      gsub('{{firstname}}', @user.firstname).
      gsub('{{invitation_url}}', url_for(onboarding_start_url(token: @user.invitation_token)))
  end
end
