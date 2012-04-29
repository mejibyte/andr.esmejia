class Admin::PostsController < Admin::BaseController
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to @post, :notice => "The post was updated!"
    else
      render :new
    end
  end
end
