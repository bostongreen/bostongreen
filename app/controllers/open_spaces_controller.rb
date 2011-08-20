class OpenSpacesController < ApplicationController
  caches_page :show

  def show
    @space = OpenSpace.find(params[:id])
    @features = @space.features
  end

end
