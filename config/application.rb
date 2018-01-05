require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ohoronka
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: false
      g.stylesheets     false
      g.javascripts     false
      g.helper false
      g.decorator   false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.time_zone = 'Kyiv'

    # Configuring cache store
    REDIS_CONFIG = config_for('redis').deep_symbolize_keys # YAML.load(ERB.new(File.read(Rails.root.join('config/redis.yml'))).result)[Rails.env].deep_symbolize_keys
    config.cache_store = :redis_store, REDIS_CONFIG[:cache], {expires_in: 90.minutes }

    ::FCM_CONFIG = config_for('fcm').deep_symbolize_keys

    ::AWS_CONFIG = config_for('aws').deep_symbolize_keys

    # def read_config(name, env: Rails.env)
    #   YAML.load(ERB.new(File.read(Rails.root.join("config/#{name}.yml"))).result)[env].deep_symbolize_keys
    # end

    config.i18n.default_locale = :uk
  end
end
