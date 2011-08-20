class MapController < ApplicationController
  
  def index
    if  !params[:neighborhood].blank?
      region = Region.find(params[:neighborhood])
      
      @open_spaces = OpenSpace.build_feature_collection(region.open_spaces)
      @features = Feature.build_feature_collection(region.features)
    elsif !params[:open_space].blank?
      
      open_space = OpenSpace.where(:id => params[:open_space])
      
      @features = Feature.build_feature_collection(open_space.first.features)
      @open_spaces = OpenSpace.build_feature_collection(open_space)
      @open_spaces_name = open_space.name
    elsif !params[:feature].blank?      
      feature = Feature.where(:id => params[:feature])
      
      @features = Feature.build_feature_collection(feature)
      @open_spaces = build_nearby_feature_resource(OpenSpace,feature.first.location,0.008)
    elsif !params[:lat].blank? && !params[:lng].blank?
      point = Point.from_x_y(params[:lng].to_f,params[:lat].to_f,4326)
      
      @open_spaces = build_nearby_feature_resource(OpenSpace,point)
      @features = build_nearby_feature_resource(Feature,point)
    elsif bounding_box
      @open_spaces = build_feature_resource(OpenSpace,bounding_box)
      @features = build_feature_resource(Feature,bounding_box)
    end
    
  end

end