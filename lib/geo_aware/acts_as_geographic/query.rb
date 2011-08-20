module GeoAware
  module ActsAsGeographic
    ##
    # Provides common location-based querying to models acting as geographic.
    # While the methods properly add table names, they should still be configured
    # to also be able the change "the_geom"
    # 
    # @author Patrick Robertson
    # @since 1.4.3
    # @todo refactor location field.
    #
    ##
    module Query
      
      module ClassMethods
        ##
        # Adds a distance attribute into a query based upon a lat,lng pair.
        #
        # @todo refactor location field.
        ##
        def select_distance(lat,lng)
          select("ST_Distance(#{self.to_s.tableize}.location, ST_GeomFromText('POINT (#{lng.to_f} #{lat.to_f})', 4326)) AS distance")
        end
        
        ##
        # Orders records by distance given a lat,lng pair.
        #
        # @todo refactor location field.        
        ##
        def ordered_by_distance(lat,lng)
          order("ST_Distance(#{self.to_s.tableize}.location, ST_GeomFromText('POINT (#{lng.to_f} #{lat.to_f})', 4326))")
        end

        ##
        # Finds all records within a certain distance of another geometry.
        #
        # @todo refactor location field.        
        ##
        def within(geography,distance)
           where("ST_DWithin(#{self.to_s.tableize}.location, ?, ?)", geography, distance)
        end
        
        ##
        # Finds any geometries intersecting a lat,lng point.
        #
        # @todo refactor location field.        
        ##
        def intersecting(lat,lng)
          geography = Point.from_x_y(lng.to_f,lat.to_f,4326)
          containing(geography)
        end

        ##
        # Finds any geometries intersecting another geometry.
        #
        # @todo refactor location field.        
        ##
        def containing(location)
          where("ST_Intersects(#{self.to_s.tableize}.location,?)",location)
        end
      end
      
    end
  end
end