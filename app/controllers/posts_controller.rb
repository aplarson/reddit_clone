class PostsController < ApplicationController
  before_action :ensure_post_authorship, :only  => [:edit, :update, :destroy]
  
  def show
    @post = Post.find(params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  def ensure_post_authorship
    return redirect_to new_session_url if current_user.nil?
    unless Post.find(params[:id]).author_id == current_user.id
      redirect_to post_url(params[:id])
    end
  end
  
  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    Post.destroy(params[:id])
    redirect_to user_url(current_user)
  end
  
  private
    def post_params
      params.require(:post)
      .permit(:title, :description, :content, :url, sub_ids: [])
    end
  
end