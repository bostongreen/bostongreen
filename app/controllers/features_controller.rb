class FeaturesController < ApplicationController
  caches_page :show
  
  def index
    @features = Feature.all
  end

  def show
    @feature = Feature.find(params[:id])
  end

end
