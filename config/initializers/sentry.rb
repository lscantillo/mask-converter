Sentry.init do |config|
  config.dsn = ENV.fetch('SENTRY_KEY')
  config.environment = Rails.env
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]
  config.traces_sampler = lambda do |context|
    true
  end
end