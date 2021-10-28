class WalksController < ApplicationController
  before_action :authenticate_user!
  include Common
  helper_method :sort_column, :sort_direction

  def new
    @walk = Walk.new
  end

  def create
    @walk = Walk.new(walk_params)
    @walk.user_id = current_user.id
    if @walk.save
      flash[:notice] = '保存が完了しました'
      redirect_to walks_path
    else
      @user = current_user
      @walks = Walk.new
      render :new
    end
  end

  def index
    @walks = Walk.order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
    @user = current_user
    @walk_ranking = get_walk_ranking
  end

  def show
    @walk = Walk.find(params[:id])
    @user = @walk.user
    @walk_comment = WalkComment.new
    @walk_ranking = get_walk_ranking
  end

  def edit
    @walk = Walk.find(params[:id])
    if @walk.user == current_user
      render "edit"
    else
      redirect_to walks_path
    end
  end

  def update
    @walk = Walk.find(params[:id])
    if @walk.update(walk_params)
      flash[:notice] = '修正が完了しました'
      redirect_to walk_path(@walk.id)
    else
      render :edit
    end
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

  def sort_direction
    %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort_column
    Walk.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end
end
