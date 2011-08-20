class NearbyEventsController < ApplicationController
  def index
    open_space = OpenSpace.find(params[:open_space_id])
    @events = open_space.events
    render "events/index"
  end

end
