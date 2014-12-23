require 'rollbar/rails'

Rollbar.configure do |config|
  config.access_token = '12d291e5253a4c0dbc7fc20e66e5ba5a'

  unless Rails.env.production?
    config.enabled = false
  end

  config.exception_level_filters.merge!('ActionController::RoutingError' => 'ignore')
end
