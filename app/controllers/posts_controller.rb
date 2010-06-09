class PostsController < ApplicationController
  before_filter :require_user, :except => [:index, :show]
  
  def index
    @posts = Post.all
  end
  
  def show
    @post = Post.find(params[:id])
  end
end
