class PostsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :authenticate_require, only: [:edit,:update,:destroy]
  
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_param)
    if @post.save
      flash[:notice] = "Post Successfully created..."
      redirect_to posts_path
    else
      render :new 
    end
  end

  def index
    @comment = Comment.new
    @posts = Post.where("(view_untill IS NULL) OR ((view_untill IS NOT NULL)
      AND (view_untill >= ?))", Date.today).page(params[:page])
  end

  def edit
  end

  def destroy
    @post.destroy
    redirect_to :back
  end


  def update
    if @post.update_attributes(post_param)
      redirect_to posts_path, notice: "The post has been updated"
    end
  end

  def remove_image
    @post = Post.find(params[:id])
    @post.remove_image!
    redirect_to :back
  end


  private 
  
  def post_param
    params.require(:post).permit(:content, :visibility, :image, :view_untill)
  end

  def authenticate_require
    @post = Post.find(params[:id])
    unless current_user.id == @post.user.id
      flash[:error] = "Access Denied...!!"
      redirect_to root_path
    end
  end
end