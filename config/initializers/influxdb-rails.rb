if Rails.env.production?
  InfluxDB::Rails.configure do |config|
    config.influxdb_database = 'campplaner'
    config.influxdb_username = 'campplaner'
    config.influxdb_password = 'fE9groy9phuk5jAk8At1'
    config.influxdb_hosts    = %w(178.79.148.131)
    config.influxdb_port     = 8086
    config.async             = true

    config.instrumentation_enabled = false
  end

  ActiveSupport::Notifications.subscribe 'process_action.action_controller' do |name, started, finished, unique_id, payload|
    log = {
      http_status: payload[:status],
      uri: payload[:path],
      view_runtime: (payload[:view_runtime] || 0).ceil,
      db_runtime: (payload[:db_runtime] || 0).ceil,
      total_runtime: ((finished - started)*1000).ceil,
      hostname: Socket.gethostname,
    }

    InfluxDB::Rails.client.write_point('rails.logs', log)
  end
end
