class TestController < ApplicationController
  layout 'empty'
  skip_before_action :authorize

  def index

  end
end
