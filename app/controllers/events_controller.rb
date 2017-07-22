class EventsController < ApplicationController
  layout 'facility'

  def index
    # TODO add pagination and filters
    @events = current_user.objects.find(params[:guarded_object_id]).events.mobile_list
  end

end
