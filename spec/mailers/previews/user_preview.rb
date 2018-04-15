# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview
  def send_password_reset
    UserMailer.send_password_reset(User.new(password_reset_token: SecureRandom.urlsafe_base64))
  end
end
