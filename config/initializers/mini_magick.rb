if Rails.env.production?
  MiniMagick.configure do |config|
    config.cli_path = '/usr/bin'
    config.processor = 'mogrify'
  end
end
