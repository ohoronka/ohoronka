class UserMailer < ApplicationMailer
  def send_password_reset(user)
    @user = user.decorate
    mail(to: @user.mail_to, subject: I18n.t('password_reset'))
  end
end
