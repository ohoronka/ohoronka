class FacilitySharesController < ApplicationController
  before_action :share, only: [:edit, :update]

  def index
    @shares = facility.shares.includes(:user).page(params[:page])
  end

  def new
    @share = facility.shares.new
  end

  # def edit
  #
  # end

  # def update
  #   if @share.update(edit_share_params)
  #     flash[:notice] = t('msg.updated')
  #     redirect_to action: :index
  #   else
  #     render :edit
  #   end
  # end

  def create
    @share = facility.shares.new(share_params)
    if @share.save
      share.user.notifications.create(event: :facility_share, target: @share, source: current_user)
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
    params.require(:facility_share).permit(:user_uuid_or_email)
  end

  # def edit_share_params
  #   params.require(:facility_share).permit(:role)
  # end
end
