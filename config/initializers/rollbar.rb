require 'rollbar/rails'

Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']
  config.enabled = ENV['ROLLBAR_ACCESS_TOKEN'].present?
  config.exception_level_filters.merge!('ActionController::RoutingError' => 'ignore')
  config.environment = ENV['ROLLBAR_ENV'] || Rails.env
end
