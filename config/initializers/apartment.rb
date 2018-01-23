require 'apartment/elevators/generic'

Apartment.configure do |config|
  config.excluded_models = %w{Organization Camp}
  config.tenant_names = lambda { Camp.pluck :schema_name }
end

require 'rescued_apartment_middleware'

Rails.application.config.middleware.use 'Apartment::Elevators::Generic', lambda { |request|
  schema = request.host.downcase.gsub(/\./, '_') # lala.example.org => lala_example_org
  schema.gsub!('_dk-campbuddy_test', '') if Rails.env.development?
  schema.gsub!('_127_0_0_1_xip_io', '') if Rails.env.development?
  schema
}
Apartment::Elevators::Generic.prepend RescuedApartmentMiddleware
