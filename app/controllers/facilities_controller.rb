class FacilitiesController < ApplicationController
  before_action :facility, only: [:edit, :update, :destroy, :set_next_status, :show]
  layout 'facility', except: [:index]

  def index
    @facilities = current_user.facilities
    redirect_to @facilities.take if @facilities.any?
  end

  def show
    
  end

  def edit

  end

  def update
    if @facility.update(facility_params)
      redirect_to action: :index
    else
      render action: :edit
    end
  end

  def new
    @facility = current_user.account.facilities.new
  end

  def create
    @facility = current_user.account.facilities.new(facility_params)
    if @facility.save
      redirect_to facilities_path
    else
      render action: :new
    end
  end

  def set_next_status
    @facility.update(status: @facility.next_status)
    render '_update_facility'
  end

  def update_facility
    render '_update_facility'
  end

  private

  helper_method def facility
    @facility = current_user.facilities.find(params[:id])
  end

  def facility_params
    params.require(:facility).permit(:name)
  end
end
