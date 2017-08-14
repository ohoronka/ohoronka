class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to({action: :edit}, notice: 'Record was successfully updated')
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
