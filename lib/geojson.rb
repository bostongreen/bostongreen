require 'geo_ruby'
require 'json/pure'
include GeoRuby::SimpleFeatures

module GeoRuby
  module SimpleFeatures
    class Geometry
      def self.from_geojson(data, srid=DEFAULT_SRID)
        data ||= {}
        if data.is_a?(String)
          require 'active_support'
          data = ActiveSupport::JSON::decode(data)
        end
        coords = data['coordinates'] || data[:coordinates]
        data_type = data['type'] || data[:type]
        case data_type
        when 'Point','LineString','Polygon','MultiPoint','MultiLineString','MultiPolygon'
          Kernel.const_get(data_type).from_coordinates(coords, srid)
        when 'GeometryCollection'
          geometriesJson = data['geometries'] || data[:geometries]
          geometries = geometriesJson.collect{|geom| from_geojson(geom)}
          GeometryCollection.from_geometries(geometries, srid)
        when 'Feature'
          geometryJson = data['geometry'] || data[:geometry]
          properties = data['properties'] || data[:properties]
          id = data['id'] || data[:id]
          Feature.new(from_geojson(geometryJson), properties, id)
        when 'FeatureCollection'
          features = data['features'] || data[:features]
          FeatureCollection.new(features.collect { |feature| from_geojson(feature) })
        end
      end
    end
    class Point
      def to_json(options = {})
        { :type => "Point", 
          :coordinates => (with_z ? [self.x, self.y, self.z] : [self.x, self.y])
        }.to_json(options)
      end
    end
    class LineString
      def to_json(options = {})
        coords = self.points.collect { |point| with_z ? [point.x, point.y, point.z] : [point.x, point.y] }
        {:type => "LineString", :coordinates => coords}.to_json(options)
      end
    end
    class Polygon
      def to_json(options = {})
        coords = self.collect{|ring| ring.points.collect{|point| with_z ? [point.x, point.y, point.z] : [point.x, point.y] } }
        {:type => "Polygon", :coordinates => coords }.to_json(options)
      end
    end
    class MultiPoint
      def to_json(options = {})
        coords = self.geometries.collect {|geom| with_z ? [geom.x, geom.y, geom.z] : [geom.x, geom.y]}
        {:type => "MultiPoint", :coordinates => coords}.to_json(options)
      end
    end
    class MultiLineString
      def to_json(options = {})
        coords = self.geometries.collect {|geom| geom.points.collect {|point| with_z ? [point.x, point.y, point.z]:[point.x, point.y] }}
        {:type => "MultiLineString", :coordinates => coords}.to_json(options)
      end
    end
    class MultiPolygon
      def to_json(options = {})
        coords = self.geometries.collect{|poly| poly.collect{|ring| ring.points.collect{|point| with_z ? [point.x, point.y, point.z]:[point.x, point.y] }}}
        {:type => "MultiPolygon", :coordinates => coords}.to_json(options)
      end
    end
    class GeometryCollection
      def to_json(options = {})
        {:type => "GeometryCollection", :geometries => self.geometries}.to_json(options)
      end
    end

    class GeoFeature
      attr_accessor :geometry
      attr_accessor :properties
      attr_accessor :id

      def initialize(geometry, properties={}, id=nil)
        @geometry=geometry
        @properties=properties
        @id=id
      end

      def to_json(options = {})
        result = {:type => "Feature",
          :geometry => @geometry,
          :properties => @properties}
        result[:id] = @id if @id != nil  
        return result.to_json(options)
      end

      def ==(other)
        if other.class != self.class
          false
        else
          @geometry==other.geometry and @properties==other.properties and @id==other.id
        end
      end
    end
    
    class FeatureCollection
      attr_accessor :features, :properties
      def initialize(features=[],properties={})
        @features=features
        @properties=properties
      end

      def to_json(options={})
        {:type => "FeatureCollection", :features => @features, :properties => @properties}.to_json(options)
      end

      def ==(other)
        if other.class != self.class
          false
        else
          @features==other.features
        end
      end
    end
  end
end