class FacilitiesController < ApplicationController
  before_action :facility, only: [:edit, :update, :destroy, :set_next_status, :show]

  def index
    @facilities = current_user.facilities.owned.page(params[:page])
    current_user.notifications.facility_share.unread.update_all(unread: false)
    redirect_to @facilities.to_a.first if (@facilities.to_a.count == 1) && (request.fullpath == '/')
  end

  def shared
    @facilities = current_user.facilities.shared
    current_user.notifications.facility_share.unread.update_all(unread: false)
  end

  def show
    
  end

  def edit

  end

  def update
    if @facility.update(facility_params)
      flash[:notice] = t('msg.updated')
      redirect_to action: :index
    else
      render action: :edit
    end
  end

  def new
    @facility = Facility.new
  end

  def create
    @facility = current_user.facilities.new(facility_params)
    @facility.users << current_user
    if @facility.save
      flash[:notice] = t('msg.created')
      redirect_to facilities_path
    else
      render action: :new
    end
  end

  def destroy
    @facility.destroy
    flash[:notice] = t('msg.destroyed')
    redirect_to action: :index
  end

  def set_next_status
    @facility.update(status: @facility.next_status)

    respond_to do |format|
      format.html { redirect_to action: :show }
      format.json { render json: {ok: true, facility: facility} }
    end
  end

  private

  helper_method def facility
    @facility = current_user.facilities.owned.find_by(id: params[:id])
  end

  def facility_params
    params.require(:facility).permit(:name)
  end
end
