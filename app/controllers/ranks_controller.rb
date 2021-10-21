class RanksController < ApplicationController
  @user_walk_count_ranks = User.where(id: Walk.group(:user_id).order('count(user_id) desc').pluck(:user_id))
end
