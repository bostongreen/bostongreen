class SearchController < ApplicationController
  def index
    
    @search_term = params[:q] || "waffles"
    search =  ThinkingSphinx.search @search_term, :page => 1, :per_page => 25, :match_mode => :extended
    @spaces = search.map{|array| [array.id, array.name, array.class.to_s]}
    @search_count = ThinkingSphinx.search_count @search_term, :match_mode => :extended
  end

end
