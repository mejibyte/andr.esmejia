class Admin::PostsController < Admin::BaseController
  def new
    @post = Post.new
  end
  
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
  
  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to post_path(@post), :notice => "Successfully created post."
    else
      render :new
    end
  end

end
