class Walk < ApplicationRecord
  belongs_to :user
  attachment :walk_image
  has_many :walk_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
