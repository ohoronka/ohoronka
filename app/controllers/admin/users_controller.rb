class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:login_as, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def login_as
    SessionService.sign_in_as(@user, self, current_admin)
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
