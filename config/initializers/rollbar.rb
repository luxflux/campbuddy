require 'rollbar/rails'

Rollbar.configure do |config|
  config.access_token = 'e61ee5cf47784faa84a7deb14bb6385c'
  config.enabled = Rails.env.production? || Rails.env.staging?
  config.exception_level_filters.merge!('ActionController::RoutingError' => 'ignore')
  config.environment = ENV['ROLLBAR_ENV'] || Rails.env
end
