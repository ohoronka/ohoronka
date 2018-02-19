credentials = Rails.application.config_for('liqpay')
::Liqpay.configure do |config|
  config.public_key = credentials['public_key']
  config.private_key = credentials['private_key']
end
