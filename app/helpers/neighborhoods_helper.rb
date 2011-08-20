module NeighborhoodsHelper
  def list_cache_store(id,page,filter)
    ret_val = "neighborhood-#{id}"
    ret_val += "-#{page}" if page
    ret_val += "-#{filter}" if filter
    ret_val
  end
  
  def neighborhood_nav_uri
    "/neighborhoods/#{params[:id]}"
  end
end
