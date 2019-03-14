class PostsController < ApplicationController
  layout 'timeline'

  def index
    @posts = Post.order(:published_at)
    @posts = @posts.by_author(params[:by_author]) if params[:by_author].present?
    @posts = @posts.by_search(params[:by_search]) if params[:by_search].present?
  end
end
