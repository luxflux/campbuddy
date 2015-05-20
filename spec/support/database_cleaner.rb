RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)

    # feature tests
    Apartment::Tenant.drop('www_example_com') rescue nil
    orga = Organization.create! name: 'default2', domain: 'example.com'
    Camp.create! name: 'default2', subdomain: 'www', organization: orga
  end

  config.around(:each) do |block|
    Apartment::Tenant.switch('www_example_com') do
      block.call
    end
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.around(:each, js: true) do |block|
    DatabaseCleaner.strategy = :truncation

    Apartment::Tenant.drop('127_0_0_1') rescue nil
    orga = Organization.create! name: 'default', domain: '0.0.1'
    Camp.create! name: 'default', subdomain: '127', organization: orga

    Apartment::Tenant.switch('127_0_0_1') do
      block.call
    end
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:each, js: true) do
    DatabaseCleaner.strategy = :truncation

    # tables have been emptied as we used :truncation
    Apartment::Tenant.drop('www_example_com') rescue nil
    orga = Organization.create! name: 'default2', domain: 'example.com'
    Camp.create! name: 'default2', subdomain: 'www', organization: orga
  end
end
