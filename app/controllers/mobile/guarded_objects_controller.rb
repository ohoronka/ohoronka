class Mobile::GuardedObjectsController < ApplicationController
  layout 'mobile'

  def index
    @objects = current_user.objects
    redirect_to mobile_guarded_object_path(@objects.first) if @objects.count == 1
  end

  def show
    @object = current_user.objects.find(params[:id])
  end
end
