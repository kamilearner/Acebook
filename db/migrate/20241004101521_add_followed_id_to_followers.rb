class AddFollowedIdToFollowers < ActiveRecord::Migration[7.1]
  def change
    add_column :followers, :followed_id, :integer
  end
end
