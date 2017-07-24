class EventsController < ApplicationController
  layout 'facility'

  def index
    # TODO add pagination and filters
    @events = current_user.facilities.find(params[:facility_id]).events.dashboard_list
  end

  protected

  helper_method def facility
    @facility ||= current_user.facilities.find(params[:facility_id])
  end

end
