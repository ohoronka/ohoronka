class TestController < ApplicationController
  layout 'application'
  skip_before_action :authorize

  def index
  end
end
