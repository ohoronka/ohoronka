class FacilitySharesController < ApplicationController
  layout 'facility'
  before_action :share, only: [:edit, :update]

  def index
    @shares = facility.shares.includes(:user)
  end

  def share_with_friend
    @friends = current_user.friends
  end

  def new
    @friend = current_user.friends.find(params[:friend_id])
    @share = facility.shares.new(user: @friend)
  end

  def edit

  end

  def update
    if @share.update(edit_share_params)
      flash[:notice] = t('msg.updated')
      redirect_to action: :index
    else
      render :edit
    end
  end

  def create
    @friend = current_user.friends.find(share_params[:user_id])
    @share = facility.shares.new(user: @friend, role: share_params[:role])
    if @share.save
      @friend.notifications.create(event: :facility_share, target: @share, params: {initiator: current_user.id})
      flash[:notice] = t('msg.created')
      redirect_to action: :index
    else
      render :new
    end
  end

  def destroy
    facility.shares.find(params[:id]).destroy
    flash[:notice] = t('msg.destroyed')
    redirect_to action: :index
  end

  private

  helper_method def facility
    @facility ||= current_user.facilities.find(params[:facility_id])
  end

  def share
    @share ||= facility.shares.find(params[:id])
  end

  def share_params
    params.require(:facility_share)
  end

  def edit_share_params
    params.require(:facility_share).permit(:role)
  end
end
