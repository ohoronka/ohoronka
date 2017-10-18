class ChannelsController < ApplicationController
  before_action :channel, only: [:destroy, :show, :update]

  def select_type

  end

  def index
    @channels = current_user.channels
  end

  def new
    @channel = current_user.channels.new(type: "Channel::#{params[:type]}")
  end

  def create
    @channel = current_user.channels.build(channel_params)
    if @channel.save
      flash[:notice] = t('msg.created')
      redirect_to action: :show, controller: :channels, id: @channel
    else
      render :new
    end
  end

  def show

  end

  def destroy
    @channel.destroy
    flash[:notice] = t('msg.destroyed')
    redirect_to action: :index
  end

  private

  def channel_params
    params.require(:channel).permit(:type)
  end

  def channel
    @channel ||= current_user.channels.find(params[:id])
  end

end
