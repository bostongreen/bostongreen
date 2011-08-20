require 'geo_aware/acts_as_geographic'

##
# Quick and dirty Rails plugin that adds common geo-aware 
# functionality to any models that require it.  Keeps our models
# much DRY'er.  
#
# @author Patrick Robertson
# @since 1.4.3
# @todo all naming location column in acts_as_geographic.
##
module GeoAware
  ActiveRecord::Base.send :include, GeoAware::ActsAsGeographic
end