class UsersController < ApplicationController
  include Common

  def index
    @users = User.all
    @user = current_user
    @walk_ranking = get_walk_ranking
  end

  def show
    @user = User.find(params[:id])
    @walks = @user.walks
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
end
