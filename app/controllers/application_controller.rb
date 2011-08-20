class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :build_bounding_box
  
  def bounding_box
    @bounding_box ||= session[:bounding_box]
  end
  
  private 
  def build_bounding_box
    session[:bounding_box] = nil
    if params[:box]
      box = params[:box].split(",").map{ |d| d.to_f}
      if box.size == 4
        points = [ 
                  [ 
                    [ box.at(0),box.at(1) ],
                    [ box.at(0),box.at(3) ],
                    [ box.at(2),box.at(3) ],
                    [ box.at(2),box.at(1) ],
                    [ box.at(0),box.at(1) ]
                  ]
                ]
        session[:bounding_box] = Polygon.from_coordinates(points,4326)
      end
    end
  end
  
  def build_feature_resource(klass,resource)
    collection = klass.send(:containing,resource)
    klass.send(:build_feature_collection,collection)
  end
  
  def build_nearby_feature_resource(klass,resource,distance=0.01)
    collection = klass.send(:within,resource,distance)
    klass.send(:build_feature_collection,collection)
  end
  
  def request_protocol_host_port
    return request.protocol + request.host + ":" + request.port.to_s if request.port
    request.protocol + request.host
  end
end
