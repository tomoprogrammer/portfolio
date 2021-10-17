class WalksController < ApplicationController
  def new
    @walk = Walk.new
  end

  def create
    @walk = Walk.new(walk_params)
    @walk.user_id = current_user.id
    @walk.save
    redirect_to walks_path
  end

  def index
    @walks = Walk.all
    @user = current_user
  end

  def show
    @walk = Walk.find(params[:id])
    @user = @walk.user
    @walk_comment = WalkComment.new
    
  end

  def edit
    @walk = Walk.find(params[:id])
  end

  def update
    @walk = Walk.find(params[:id])
    @walk.update(walk_params)
    redirect_to walk_path(@walk.id)
  end

  def destroy
    @walk = Walk.find(params[:id])
    @walk.destroy
    redirect_to walks_path
  end

  private

  def walk_params
    params.require(:walk).permit(:walk_count, :memo, :walk_image)
  end
end
