module Clearance::Authorization
  extend ActiveSupport::Concern

  protected

  def url_after_denied_access_when_signed_out
    main_app.sign_in_url
  end
end

Clearance.configure do |config|
  config.mailer_sender = 'buddy@campbuddy.ch'
  config.routes = false
end
