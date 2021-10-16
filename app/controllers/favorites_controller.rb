class FavoritesController < ApplicationController
  
  def create
    walk = Walk.find(params[:walk_id])
    favorite = current_user.favorites.new(walk_id: walk.id)
    favorite.save
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    walk = Walk.find(params[:walk_id])
    favorite = current_user.favorites.find_by(walk_id: walk.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end
  
end
