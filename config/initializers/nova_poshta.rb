NovaPoshta.configure do |config|
  config.api_key = Rails.application.config_for('nova_poshta')['api_key']
end
