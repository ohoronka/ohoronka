class Mobile::GuardedObjectsController < ApplicationController
  def index
    @objects = current_user.objects
    redirect_to @objects.take if @objects.count == 1
  end

  def show
    @object = current_user.objects.find(params[:id])
  end
end
