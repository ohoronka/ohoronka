module Mqtt
  def self.table_name_prefix
    'mqtt_'
  end


  # def password_hash(password, salt: nil, iterations: 901)
  #   salt ||= SecureRandom.base64(12)
  #   password_hash = Base64.encode64(PBKDF2.new(password: password, salt: salt, iterations: iterations).bin_string)[0..31]
  #   "PBKDF2$sha256$#{iterations}$#{salt}$#{password_hash}"
  # end

  def self.password_hash(password, salt: nil, iterations: 901)
    salt ||= SecureRandom.base64(12)

    hash = OpenSSL::PKCS5.pbkdf2_hmac(password, salt, iterations, 24, OpenSSL::Digest::SHA256.new)
    encoded_hash = Base64.strict_encode64(hash)

    "PBKDF2$sha256$#{iterations}$#{salt}$#{encoded_hash}"
  end

end
