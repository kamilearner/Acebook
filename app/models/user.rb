class User < ApplicationRecord

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy


  has_many :active_relationship, class_name: "Follower", foreign_key: :"follower_id", dependent: :destroy
  has_many :passive_relationship, class_name: "Follower", foreign_key: :"followed_id", dependent: :destroy
  # has_many: This is a Rails association method that sets up a one-to-many relationship
  # :active_relationships: This is a symbolic name for this association. It’s used in the code to refer to this specific relationship.
  # class_name: "Follower": This specifies that the association is related to the Follower model.
  # foreign_key: :"follower_id": This tells Rails which column in the followers table should be used to link to the User model. In this case, follower_id refers to the ID of the user who is following someone else.
  # dependent: :destroy: This option indicates that when a user is deleted, any associated Follower records where the user is the follower will also be deleted.

  has_many :followed_users, through: :active_relationship, source: :followed_user
  has_many :follower_users, through: :passive_relationship, source: :follower_user
  # This lines essentially allows you to get all users that the current user is following:
  # current_user.follower_users


  def authenticate(psw)
    if psw == password
      true
    else
      false
    end
  end

end
