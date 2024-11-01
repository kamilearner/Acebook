require 'rails_helper'

RSpec.describe Follower, type: :model do
  it 'is valid with both followe and followe ids' do
    user_1 = User.create(username: "test name 1", password: "test123")
    user_2 = User.create(username: "test name 2", password: "test123")
    followers = Follower.create(follower_id: user_1.id, followed_id: user_2.id)
    expect(followers).to be_valid
  end

  it "is not valid if follower_id is missing" do
    user_1 = User.create(username: "test name 1", password: "test123")
    followers = Follower.create(follower_id: user_1.id, followed_id: nil)
    expect(followers).not_to be_valid
  end

  it "is not valid if followed_id is missing" do
    user_2 = User.create(username: "test name 2", password: "test123")
    followers = Follower.create(follower_id: nil, followed_id: user_2.id)
    expect(followers).not_to be_valid
  end

  it "is not valid if following relationship alredy exist" do
    user_1 = User.create(username: "test name 1", password: "test123")
    user_2 = User.create(username: "test name 2", password: "test123")
    Follower.create(follower_id: user_1.id, followed_id: user_2.id)
    user_1 = User.create(username: "test name 1", password: "test123")
    user_2 = User.create(username: "test name 2", password: "test123")
    followers_2 = Follower.create(follower_id: user_1.id, followed_id: user_2.id)
    expect(followers_2).not_to be_valid
  end
end
