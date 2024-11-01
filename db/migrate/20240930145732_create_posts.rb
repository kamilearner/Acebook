class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :user, null:false, foreign_key: true
      t.text :message, null: false
      t.string :image
      t.timestamps
    end
  end
end
