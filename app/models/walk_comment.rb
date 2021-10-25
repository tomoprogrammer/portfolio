class WalkComment < ApplicationRecord
  belongs_to :user
  belongs_to :walk

  validates :comment, presence: true
end
