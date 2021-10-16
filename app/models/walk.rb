class Walk < ApplicationRecord
  belongs_to :user
  attachment :walk_image
  has_many :walk_comments, dependent: :destroy
end
