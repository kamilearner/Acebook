class RemoveFollowingIdFromFollowers < ActiveRecord::Migration[7.1]
  def change
    remove_column :followers, :following_id, :integer
  end
end
