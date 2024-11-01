require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(id: 1, username:'test', password: 'test')
    post = Post.new(user_id: user.id, message: "test message")
    expect(post).to be_valid
  end

  it "is still valid without a comment" do
    user = User.create(id: 1, username:'test', password: 'test')
    post = Post.new(user_id: user.id, message: "")
    expect(post).to be_valid
  end

  it "is not valid without a user_id linked to" do
    expect(Post.new(user_id: nil , message: 'test')).to_not be_valid
  end
end
