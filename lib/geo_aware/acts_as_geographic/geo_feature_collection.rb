module GeoAware
  module ActsAsGeographic
    ##
    # Provides GeoJSON FeatureCollection output for models.  This is 
    # primarily being used by our API endpoint for providing the location
    # information.
    #
    # @author Patrick Robertson
    # @since 1.4.3
    ##
    module GeoFeatureCollection
      
      module ClassMethods
        
        ##
        # Builds a FeatureCollection given an enumerable set of features.
        # If you'd like to build a feature of one, be sure you use Model#where(:id=><id>)
        # instead of the Model#find(<id>).  If the enumeration responds to paginate?
        # it will also construct a properties item given pagination information.
        #
        # @parm [Enumerable] features An enumerable object that the FeatureCollection
        #   is built from.  Will build the model's entire collection ordered by name
        #   if nothing is provided.
        #
        # @return [GeoRuby::SimpleFeatures::FeatureCollection] Returns a geoJSON representation
        #   of the requested collection.
        #
        # @example Building a full collection from a model.
        #   OpenSpace.build_feature_collection
        # @example Building a FeatureCollection of spaces within a Region.
        #   spaces = OpenSpace.contained(Region.first)
        #   OpenSpace.build_feature_collection(spaces)
        #
        # @since 1.4.3
        ##
        def build_feature_collection(features=nil,options={})
          feature_collection = []
          options[:host] ||= "localhost:3000"

          features ||= order("name ASC")
          features.each do |feature|
            feature_collection << build_feature(feature,options[:host])
          end

          FeatureCollection.new(feature_collection,build_properties(features)).to_json
        end
        
        private
        
        ##
        # Builds a single Feature object.
        #
        # @since 1.4.3
        ##
        def build_feature(feature,host)
          properties = {
            :name => feature.name,
            :id => feature.id.to_s,
          }
          
          if feature.respond_to?(:photo) && feature.photo?
            properties[:image] = host + feature.photo.path(:thumb)
          end
          
          GeoFeature.new(feature.location,properties)
        end

        ##
        # Builds a propery hash if the enumerable collection is paginated.
        #
        # @since 1.4.3
        ##
        def build_properties(features)
          properties = {}
          if is_paginated?(features)
            properties = {
              :current_page => features.current_page.to_s,
              :total_pages => features.total_pages.to_s,
              :per_page => features.per_page.to_s
            }
          end
          properties
        end
        
        ##
        # Checks whether a feature responds to pagination or not.
        #
        # @since 1.4.3
        ##
        def is_paginated?(features)
          features.respond_to?(:current_page) && features.respond_to?(:total_pages) && features.respond_to?(:per_page)
        end

      end
      
    end
  end
end