class PasswordResetsController < ApplicationController
  skip_before_action :authorize
  before_action :set_user, only: [:edit, :update]
  layout 'sign_up'

  def new
  end

  def create
    @email = params[:email]
    if user = User.find_by(email: @email)
      user.send_password_reset
    end
  end

  def edit
  end

  def update
    if @user.update(user_params.merge(password_reset_token: nil, password_reset_token_expires_at: nil))
      SessionService.new.authorize(@user, self)
      redirect_to root_path, notice: t('password_has_been_changed')
    else
      render action: :edit
    end
  end

  private

  def set_user
    @user ||= User.where.not(password_reset_token: nil).find_by(password_reset_token: params[:token])
    unless @user && @user.password_reset_token_expires_at.future?
      redirect_to({action: :new}, notice: t('password_reset_token_has_expired_or_not_found'))
    end
    @user
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
