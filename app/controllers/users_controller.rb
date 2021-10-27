class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  helper_method :sort_column, :sort_direction
  include Common

  def index
    @users = User.page(params[:page]).per(10)
    @user = current_user
    @walk_ranking = get_walk_ranking
  end

  def show
    @user = User.find(params[:id])
    @walks = @user.walks.order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
    # byebug
    @walk_ranking = get_walk_ranking
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'ユーザの更新が完了しました'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort_column
    Walk.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end
end
