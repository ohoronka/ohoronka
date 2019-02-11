NOVA_POSHTA_CONFIG = Rails.application.config_for('nova_poshta')
NovaPoshta.configure do |config|
  config.api_key = NOVA_POSHTA_CONFIG['api_key']
end
