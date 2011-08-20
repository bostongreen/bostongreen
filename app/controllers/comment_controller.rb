class CommentController < ApplicationController
  def show
    @disqus_id = 'open_space_' + params[:id]
    @space = OpenSpace.first_space_without_location(params[:id])
    render "comments/comment", :layout => false
  end

end
