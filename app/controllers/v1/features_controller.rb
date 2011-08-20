class V1::FeaturesController < V1Controller 
  respond_to :json
  
  def show
    respond_with Feature.build_feature_collection(Feature.where(:id => params[:id]))
  end
end