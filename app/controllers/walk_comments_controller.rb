class WalkCommentsController < ApplicationController
  def create
    @walk = Walk.find(params[:walk_id])
    @comment = current_user.walk_comments.new(walk_comment_params)
    @comment.user_id = current_user.id
    @comment.walk_id = @walk.id
    @comment.save
    #redirect_to walk_path(@walk)
  end

  def destroy
    @walk = Walk.find(params[:walk_id])
    @comment = WalkComment.find(params[:id])
    @comment.destroy
    #redirect_to walk_path(params[:walk_id])
  end

  private

  def walk_comment_params
    params.require(:walk_comment).permit(:comment)
  end
end
