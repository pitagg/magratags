class PostsController < ApplicationController
  layout 'timeline'

  def index
    @posts = Post.order(:published_at).by_author(params[:by_author]).by_search(params[:by_search])
  end
end
