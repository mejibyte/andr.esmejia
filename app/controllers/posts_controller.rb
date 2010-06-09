class PostsController < ApplicationController
  before_filter :require_user, :except => [:index, :show]
  
  def index
    @posts = Post.all
  end
  
  def new
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      flash[:notice] = "The post was updated!"
      redirect_to post_path(@post)
    else
      render :action => "edit"
    end
  end
end
