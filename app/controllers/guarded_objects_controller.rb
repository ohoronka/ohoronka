class GuardedObjectsController < ApplicationController
  before_action :set_object, except: [:index]

  def index
    redirect_to current_user.objects.take if current_user.objects.any?

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
