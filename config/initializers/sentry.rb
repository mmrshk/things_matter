# frozen_string_literal: true

Raven.configure do |config|
  config.dsn = Rails.application.credentials[:sentry_dns]
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  config.environments = %w[production staging]
  config.async = lambda do |event|
    SentryWorker.perform_async(event)
  end
end
