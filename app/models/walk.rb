class Walk < ApplicationRecord
  belongs_to :user
  attachment :walk_image
  has_many :walk_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  validates :walk_count, presence: true

  validates :memo, presence: true, length: { maximum: 100 }
end
