class PostsController < ApplicationController
  def index
    @posts = Post.all(:limit => 10)
  end
end
