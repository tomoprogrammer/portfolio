class Walk < ApplicationRecord
  belongs_to :user
  attachment :walk_image
end
