# frozen_string_literal: true

redis_creds = Rails.application.credentials[:redis]
redis_host = ENV.fetch('REDIS_HOST', redis_creds[:host])
redis_port = ENV.fetch('REDIS_PORT', redis_creds[:port])

Sidekiq.configure_server do |config|
  config.redis = {
    url: "redis://#{redis_host}:#{redis_port}/1"
  }
  schedule_file = 'config/schedule.yml'
  Sidekiq::Cron::Job.load_from_hash(YAML.load_file(schedule_file)) if File.exist?(schedule_file)
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: "redis://#{redis_host}:#{redis_port}/1"
  }
end
