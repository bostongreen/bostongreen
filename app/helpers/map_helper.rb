module MapHelper
  
  def map_list_cache_store(lng,lat,neighborhood,open_space,feature)
    ret_val = "map"
    ret_val += "-#{lng}" if lng
    ret_val += "-#{lat}" if lat
    ret_val += "-hood-#{neighborhood}" if neighborhood
    ret_val += "-space-#{open_space}" if open_space
    ret_val += "-feature-#{feature}" if feature
    ret_val
  end
  
end
