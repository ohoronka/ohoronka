CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     AWS_CONFIG[:access_key_id],
    aws_secret_access_key: AWS_CONFIG[:secret_access_key],
    region:                AWS_CONFIG[:region],
  }
  config.fog_directory  = AWS_CONFIG[:bucket]
  # config.fog_public     = true
  # config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" } # optional, defaults to {}
end
