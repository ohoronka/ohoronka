class FacilitySharesController < ApplicationController
  layout 'facility'

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

  def create
    @friend = current_user.friends.find(share_params[:user_id])
    @share = facility.shares.new(user: @friend, role: share_params[:role])
    if @share.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def destroy
    facility.shares.find(params[:id]).destroy
    redirect_to action: :index
  end

  private

  helper_method def facility
    @facility ||= current_user.facilities.find(params[:facility_id])
  end

  def share_params
    params.require(:facility_share)
  end
end
