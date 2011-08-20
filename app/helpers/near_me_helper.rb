module NearMeHelper
  def near_list_cache_store(lng,lat,page,filter)
    ret_val = "near"
    ret_val += "-#{lng}" if lng
    ret_val += "-#{lat}" if lat
    ret_val += "-#{page}" if page
    ret_val += "-#{filter}" if filter
    ret_val
  end
  
  def near_me_nav_uri
    "/near/?lat=#{params[:lat]}&lng=#{params[:lng]}"
  end
  
end
