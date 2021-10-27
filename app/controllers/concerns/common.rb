module Common
  extend ActiveSupport::Concern

  def get_walk_ranking
    walk_sum = Walk.limit(5).order('walk_count desc').group(:user_id).sum(:walk_count)
    walk_ranking = []
    walk_sum.each do |key, value|
      user = User.find(key)
      walk_ranking += [user: user, walk_count: value]
    end

    walk_ranking
  end
end
