require 'geo_aware/acts_as_geographic/geo_feature_collection'
require 'geo_aware/acts_as_geographic/query'

module GeoAware
  ##
  # ActiveRecord::Base mixin for providing some basic geographic aware
  # functions use for Boston Green.  Provides ability to build GeoJSON
  # and some common queries.
  #
  # @since 1.4.3
  # @author Patrick Robertson
  ##
  module ActsAsGeographic
  
    def self.included(base)
      base.extend ClassMethods
    end
  
    module ClassMethods
      ##
      # Class Method mixed into ActiveRecord::Base that allows a model to gain 
      # the ability to build GeoJSON feature collections (if it can) and provides
      # some basic ARel queries that we were seeing across models.
      #
      # @todo specify the name of "the geom" column.  We use location in all current
      #   models, but this could be made to be slightly less brittle.
      # @since 1.4.3
      ##
      def acts_as_geographic(options ={})
        if defined? GeoRuby::SimpleFeatures::GeoFeature && GeoRuby::SimpleFeatures::FeatureCollection
          self.send(:extend, GeoAware::ActsAsGeographic::GeoFeatureCollection::ClassMethods)
        end
        self.send(:extend, GeoAware::ActsAsGeographic::Query::ClassMethods)
      end
    
    end
  end
end