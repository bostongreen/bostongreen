module FilterHelper
  
  def neighborhood_filter_param(id)
    {"data-neighborhood" => id }
  end
  
  def near_me_filter_param(lat,lng)
    {"data-lat" => lat.to_s , "data-lng" => lng.to_s}
  end

  def park_filter_option(name,value)
    content_tag(:option, name,:selected => (params[:filter] == value), :value => value)
  end
end
