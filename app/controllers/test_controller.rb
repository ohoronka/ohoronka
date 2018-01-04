class TestController < ApplicationController
  layout 'empty'
  skip_before_action :authorize

  def index
    @request = request
  end
end
