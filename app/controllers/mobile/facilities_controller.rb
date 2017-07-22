class Mobile::FacilitiesController < ApplicationController
  layout 'mobile'

  before_action :set_facility, only: [:show, :set_next_status]

  def index
    @facilities = current_user.facilities
    redirect_to mobile_facility_path(@facilities.first) if @facilities.count == 1
  end

  def show

  end

  def set_next_status
    @facility.update(status: @facility.next_status)
    redirect_to [:mobile, @facility]
  end

  def set_facility
    @facility = current_user.facilities.find(params[:id])
  end
end
