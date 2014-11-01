class CommentsController < ApplicationController
  def new   
    @comment = Comment.new(
      post_id: params[:post_id], 
      parent_comment_id: params[:comment_id]
    )
    
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end
  
  private
    def comment_params
      params.require(:comment).permit([:content, :post_id, :parent_comment_id])
    end
end