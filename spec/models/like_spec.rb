require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'is valid with valid attributes' do
    user_1 = User.create(id: 1, username:'test name 1', password: 'test')
    user_2 = User.create(id: 2, username:'test name 2', password: 'test')
    Post.create(user_id: user_1.id, message: "test message")
    like = Like.create(post_id: 1, user_id: user_2.id)
    expect(like).to be_valid
  end

  it "is not valid without a user id" do
    user_1 = User.create(id: 1, username:'test name 1', password: 'test')
    Post.create(user_id: user_1.id, message: "test message")
    like = Like.create(post_id: 1, user_id: nil)
    expect(like).not_to be_valid
  end

  it "is not valid if alredy liked the post" do
    user_1 = User.create(id: 1, username:'test name 1', password: 'test')
    user_2 = User.create(id: 2, username:'test name 2', password: 'test')
    Post.create(user_id: user_1.id, message: "test message")
    Like.create(post_id: 1, user_id: user_2.id)
    like_2 = Like.create(post_id: 1, user_id: user_2.id)
    expect(like_2).not_to be_valid
  end
end

