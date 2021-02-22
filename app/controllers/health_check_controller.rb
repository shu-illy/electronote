class HealthCheckController < ApplicationController
  def index
    render :text => "Alive\n", :status =>200
  end

  protected
  def allow_http?
    true
  end

end
