class ChannelsController < ApplicationController
  before_action :user
  before_action :channel, only: [:destroy, :show, :update]

  def select_type

  end

  def index
    @channels = user.channels
  end

  def new
    @channel = user.channels.new(type: params[:type])
  end

  def create
    @channel = user.channels.build(channel_params)
    if @channel.save
      redirect_to action: :show, controller: :channels, id: @channel
    else
      render :new
    end
  end

  def show

  end

  def destroy
    @channel.destroy
    redirect_to action: :index
  end

  private

  def channel_params
    params.require(:channel).permit(:type)
  end

  def channel
    @channel ||= user.channels.find(params[:id])
  end

  helper_method def user
    @user ||= account.users.find(params[:user_id])
  end

  def account
    @account ||= current_user.account
  end
end
