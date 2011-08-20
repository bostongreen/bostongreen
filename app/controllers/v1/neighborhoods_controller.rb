class V1::NeighborhoodsController < V1Controller
  
  respond_to :json
  
  def index
    if params[:lat] && params[:lng]
      regions_list = Region.find_nearby_via_coords(params[:lat], params[:lng])
      @regions = Region.build_feature_collection(regions_list)
    elsif bounding_box
      @regions = build_feature_resource(Region,bounding_box)
    else
      @regions = Region.build_feature_collection
    end
    
    respond_with @regions
  end
  
  def show
    respond_with Region.build_feature_collection(Region.where(:id => params[:id]))
  end
end