class EventsController < ApplicationController
  def index
    @events = Event.current.with_open_spaces.order("start_time asc").uniq.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @event = Event.find(params[:id])
  end

end
