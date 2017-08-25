class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :crop_avatar]
  skip_before_action :authorize, only: [:create]

  def edit

  end

  def crop_avatar

  end

  def create
    @user = User.new(user_params)
    if @user.save
      SessionService.new.authorize(@user, self)
      redirect_to root_path
    else
      render template: 'sessions/new', layout: 'sign_up'
    end
  end

  def update
    if @user.update(user_params)
      if params[:user][:avatar].present?
        render :crop_avatar
      else
        redirect_to({action: :edit}, notice: 'Record was successfully updated')
      end
    else
      render :edit
    end
  end

  private

  def set_user
    raise ActionController::RoutingError.new('Not Found') unless current_user && (params[:id].to_i == current_user.id)
    @user ||= current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :about, :email, :password, :password_confirmation, :avatar, :crop_x, :crop_y, :crop_w, :crop_h)
  end
end
