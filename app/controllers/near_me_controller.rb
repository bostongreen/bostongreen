class NearMeController < ApplicationController
  def index
    if params[:lat] && params[:lng]
      point = Point.from_x_y(params[:lng],params[:lat].to_f)
      @spaces = OpenSpace.find_nearby_spaces(params[:lat],params[:lng])
      if params[:filter]
        @spaces = @spaces.tagged_with(params[:filter])
      end
      @spaces = @spaces.paginate(:page => params[:page],:per_page => 10)
    end
  end

end