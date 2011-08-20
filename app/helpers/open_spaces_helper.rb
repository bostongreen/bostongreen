module OpenSpacesHelper

  def collapsed_feature_list?(features)
    if features.empty?
      "data-collapsed"      
    else 
      nil
    end
  end
  
  def collapsed_attribute_list?(attribute=nil)
    if attribute.blank?
      "data-collapsed"
    else
      nil
    end
  end
  
  def spatial_distance_to_human_readable(distance)
    #This is a terrible hack.
    ret_distance = number_with_precision(distance.to_f * 69, :precision => 2)
    "#{ret_distance} mi"
  end
  
  def distance(space)
    if space.respond_to? :distance
      content_tag(:p, spatial_distance_to_human_readable(space.distance), :class=> "ui-li-desc")
    end
  end
  
  def has_events?(space)
    true if space.respond_to?(:events) && !space.events.empty?
  end
end
