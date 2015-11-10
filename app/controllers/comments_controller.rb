class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_require, only: [:edit,:update,:destroy]

	def create
		@comment = current_user.comments.new(text: params[:comment][:text], post_id: params[:post_id])
	    if @comment.save
	      flash[:notice] = "Comment Successfully created..."
	      redirect_to posts_path
	    else
	      flash[:notice] = "Comment cannot be blank..."
	      redirect_to :back
	    end
	end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(text: params[:comment][:text], post_id: params[:post_id])
      redirect_to posts_path, notice: "The comment has been updated"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to :back
  end


  def authenticate_require
    @comment = Comment.find(params[:id])
    unless current_user.id == @comment.user.id
      flash[:error] = "Access Denied...!!"
      redirect_to root_path
    end
  end

end
