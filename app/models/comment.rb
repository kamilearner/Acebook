class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    validates :post_id, presence: true
    validates :message_comment, presence: true

end