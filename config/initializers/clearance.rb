module Clearance::Authorization
  extend ActiveSupport::Concern

  protected

  def url_after_denied_access_when_signed_out
    main_app.sign_in_url
  end
end

Clearance.configure do |config|
  config.allow_sign_up = false
  config.mailer_sender = 'reply@example.com'
  config.routes = false
end
