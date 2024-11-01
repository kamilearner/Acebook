class RemoveUserIdFromFollowers < ActiveRecord::Migration[7.1]
  def change
    remove_column :followers, :user_id, :integer
  end
end
