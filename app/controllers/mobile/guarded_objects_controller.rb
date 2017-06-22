class Mobile::GuardedObjectsController < ApplicationController
  layout 'mobile'

  before_action :set_object, only: [:show, :set_next_status]

  def index
    @objects = current_user.objects
    redirect_to mobile_guarded_object_path(@objects.first) if @objects.count == 1
  end

  def show

  end

  def set_next_status
    @object.update(status: @object.next_status)
    redirect_to [:mobile, @object]
  end

  def set_object
    @object = current_user.objects.find(params[:id])
  end
end
