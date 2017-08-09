class UsersController < ApplicationController
  before_action :set_user, only: [:destroy, :edit, :update]

  def index
    @users = account.users
  end

  def new
    @user = account.users.build
  end

  def create
    @user = account.users.build(user_params)
    if @user.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def edit

  end

  def destroy
    @user.destroy
    redirect_to action: :index
  end

  private

  def account
    @account ||= current_user.account
  end

  def set_user
    @user = account.users.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
