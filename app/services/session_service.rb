class SessionService
  include ActiveModel::Model

  attr_accessor :user_name, :password

  validates :user_name, presence: true
  validates :password, presence: true

  def sign_in(controller)
    return false unless valid?
    unless user =  User.find_by(email: user_name)&.authenticate(password)
      errors.add(:base, 'Wrong user or password')
      return false
    end
    controller.session[:user_id] = user.id
    user
  end

  def logout(controller)
    controller.reset_session
  end
end