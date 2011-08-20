class V1::OpenSpacesController < V1Controller 

  respond_to :json

  def index
    if params[:lat] && params[:lng]
      point = Point.from_x_y(params[:lng],params[:lat])
      if params[:distance]
        spaces_list = OpenSpace.within(point,params[:distance])
      else
        spaces_list = OpenSpace.containing(point)
      end
    elsif bounding_box
      spaces_list = OpenSpace.containing(bounding_box)
    else
      spaces_list = OpenSpace.properly_ordered
    end
    if params[:filter] || params[:category]
      filter = params[:filter] || params[:category]
      spaces_list = spaces_list.tagged_with(filter)
    end  
    spaces_list = spaces_list.paginate(:page => params[:page], :per_page => 50)
    @spaces = OpenSpace.build_feature_collection(spaces_list,:host => request_protocol_host_port)
    respond_with @spaces
  end
  
  def show 
    respond_with OpenSpace.build_feature_collection(OpenSpace.where(:id => params[:id]))
  end
  
end