class HomeController < ApplicationController
  caches_page :index
  
  def index
    @neighborhoods = Region.count
    @events = Event.current.with_open_spaces.uniq.count
  end
  
end
