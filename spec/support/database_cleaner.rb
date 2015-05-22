RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)

    # feature tests
    Apartment::Tenant.drop('127_0_0_1') rescue nil
    orga = Organization.create! name: 'default2', domain: '0.0.1'
    Camp.create! name: 'default2', subdomain: '127', organization: orga
  end

  config.around(:each) do |block|
    Apartment::Tenant.switch('127_0_0_1') do
      block.call
    end
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each, type: :feature) do
    port = 3002
    host = '127.0.0.1'
    default_url_options[:host] = host
    Capybara.app_host = "http://#{host}:#{port}"
    Capybara.server_port = port
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do |example|
    DatabaseCleaner.clean
    if example.metadata[:js]
      Apartment::Tenant.drop('127_0_0_1') rescue nil
      orga = Organization.create! name: 'default2', domain: '0.0.1'
      Camp.create! name: 'default2', subdomain: '127', organization: orga
    end
  end
end
