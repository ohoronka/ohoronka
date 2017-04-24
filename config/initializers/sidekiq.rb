Sidekiq.configure_server do |config|
  config.redis = Guardhub::Application::REDIS_CONFIG[:sidekiq]
end

Sidekiq.configure_client do |config|
  config.redis = Guardhub::Application::REDIS_CONFIG[:sidekiq]
end
