Rails.application.config.session_store :redis_store, servers: Ohoronka::Application::REDIS_CONFIG[:cache]
