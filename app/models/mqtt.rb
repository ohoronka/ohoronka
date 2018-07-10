module Mqtt
  CONFIG = YAML.load(ERB.new(File.read(Rails.root.join('config/mqtt.yml'))).result)[Rails.env].deep_symbolize_keys

  def self.user_name
    CONFIG[:user_name]
  end

  def self.password
    CONFIG[:password]
  end

  def self.host
    CONFIG[:host]
  end

  def self.table_name_prefix
    'mqtt_'
  end

  def self.as_admin(&block)
    MQTT::Client.connect("mqtt://#{Mqtt.user_name}:#{Mqtt.password}@#{Mqtt.host}", &block)
  end

  # def password_hash(password, salt: nil, iterations: 901)
  #   salt ||= SecureRandom.base64(12)
  #   password_hash = Base64.encode64(PBKDF2.new(password: password, salt: salt, iterations: iterations).bin_string)[0..31]
  #   "PBKDF2$sha256$#{iterations}$#{salt}$#{password_hash}"
  # end

  def self.password_hash(plaintext, salt_length: 12, iterations: 901, key_length: 24)
    salt = SecureRandom.base64(salt_length)

    hash = OpenSSL::PKCS5.pbkdf2_hmac(plaintext, salt, iterations, key_length, OpenSSL::Digest::SHA256.new)
    encoded_hash = Base64.strict_encode64(hash)

    "PBKDF2$sha256$#{iterations}$#{salt}$#{encoded_hash}"
  end

end
