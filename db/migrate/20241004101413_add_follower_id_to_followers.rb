class AddFollowerIdToFollowers < ActiveRecord::Migration[7.1]
  def change
    add_column :followers, :follower_id, :integer
  end
end
