require 'rails_helper'

RSpec.describe LikesController, type: :controller do

  describe "POST #create" do
    it "liking a post return a successful response" do
      user = User.create(id:1, username: "test name", password: "test123")
      session[:user_id] = user.id
      post_1 = Post.create(id:1, user_id: user.id ,message: "First post", image: nil)

      expect {
        post :create, params: { like:
        {user_id: user.id, post_id: post_1.id }
      }
      }.to change(Like, :count).by(1)

    end
  end

  describe "POST #create" do
    it "you can't like a post more than once" do
      user = User.create(id:1, username: "test name", password: "test123")
      session[:user_id] = user.id
      post_1 = Post.create(id:1, user_id: user.id ,message: "First post", image: nil)
      Like.create!(user_id:user.id, post_id:post_1.id)

      expect {
        post :create, params: { like:
        {user_id: user.id, post_id: post_1.id }
      }
      }.not_to change(Like, :count)

      expect(flash[:notice]).to match("Can't like!")
      expect(response).to redirect_to(post_1)
    end
  end

  describe "DELETE #destroy" do
    it "decrement the like count by 1" do
      user = User.create(id:1, username: "test name", password: "test123")
      session[:user_id] = user.id
      post = Post.create(id:2, user_id: user.id ,message: "Second post", image: nil)
      like = Like.create(user_id: user.id, post_id: post.id)

      expect {
        delete :destroy, params: {id: like.id}
      }.to change(Like, :count).by(-1)
    end
  end
end
