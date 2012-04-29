class PostsController < ApplicationController
  before_filter :require_user, :except => [:index, :show]
  
  def index
    @posts = Post.published.all
  end
  
  def show
    @post = logged_in? ? Post.find(params[:id]) : Post.published.find(params[:id])
    redirect_to post_url(@post), :status => :moved_permanently if params[:id] != @post.to_param
  end
  
  def new
    @post = Post.new
    render :action => "new", :layout => "admin"
  end
end
