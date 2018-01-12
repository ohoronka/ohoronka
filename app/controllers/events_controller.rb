class EventsController < ApplicationController

  def index
    @events = current_user.facilities.find(params[:facility_id]).events.ordered.page(params[:page])
  end

  protected

  helper_method def facility
    @facility ||= current_user.facilities.find(params[:facility_id])
  end

end
