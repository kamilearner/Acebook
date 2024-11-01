class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  # check to ensure user cannot like a post more than once
  validates :user_id, uniqueness: { scope: :post_id }
end
