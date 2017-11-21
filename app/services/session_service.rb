class SessionService
  include ActiveModel::Model

  attr_accessor :user_name, :password

  validates :user_name, presence: true
  validates :password, presence: true

  def sign_in(controller)
    return false unless valid?
    unless user =  User.find_by(email: user_name)&.authenticate(password)
      errors.add(:base, I18n.t('msg.wrong_email_or_password'))
      return false
    end
    authorize(user, controller)
    user
  end

  def authorize(user, controller)
    controller.send(:cookies).permanent[:auth_token] = user.auth_token
    controller.session[:user_id] = user.id
    controller.session[:admin_id] = user.id if user.admin?
  end

  def sign_out(controller)
    controller.send(:cookies).delete(:auth_token)
    controller.reset_session
  end

  def self.sign_in_as(user, controller, current_admin)
    controller.session[:user_id] = user.id if current_admin.admin?
  end
end