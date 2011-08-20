class NeighborhoodsController < ApplicationController
  caches_page :index
  
  def index  
    @neighborhoods = Region.ordered_by_name
  end

  def show
    @region = Region.find(params[:id])
    @spaces = OpenSpace.within_neighborhood(@region.id)
    if params[:filter]
      @spaces = @spaces.tagged_with(params[:filter])
    end
    @spaces = @spaces.paginate(:page => params[:page], :per_page => 10)
  end
  
end
