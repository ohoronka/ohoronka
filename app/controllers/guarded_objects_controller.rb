class GuardedObjectsController < ApplicationController
  before_action :set_object, except: [:index]

  def index
    @objects = current_user.objects
  end

  def show
    
  end

  def set_next_status
    @object.update(status: @object.next_status)
    render '_update_object'
  end

  def update_object
    render '_update_object'
  end

  private

  def set_object
    @object = current_user.objects.find(params[:id])
  end
end
