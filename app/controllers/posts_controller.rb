class PostsController < ApplicationController
  before_filter :require_user, :except => [:index, :show]
  
  def index
    @posts = Post.all
  end
  
  def show
    @post = Post.find(params[:id])
    redirect_to post_url(@post), :status => :moved_permanently if params[:id] != @post.to_param
  end
end
