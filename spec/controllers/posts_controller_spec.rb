require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET #new " do
    it "responds with 200" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "creates a post and is also valid with no image" do
      user = User.create(id: 1, username: 'test name', password: 'test')
      session[:user_id] = user.id

      expect {
          post :create, params: {
            post: { message: "Hello, world!",
                    image: nil }
          }
        }.to change(Post, :count).by(1)

      post = Post.last

      expect(response).to redirect_to(user_path(user.id))
      expect(response).to have_http_status(302)
      expect(flash[:notice]).to match('Post created successfully')
      expect(post.message).to eq("Hello, world!")
    end
  end


  describe "POST /" do
    it "does not create a post when message is nil" do
      user = User.create(id: 1, username: 'test name', password: 'test')

      post :create, params: { post: {id: 1, user_id: user.id, message: nil, image: nil } }

      expect(Post.find_by(id: 1)).to be_nil
    end
  end

  describe "GET #index" do
    it "renders the index template with all the posts " do
      user_1 = User.create(id:1, username: "test name 1", password: "test123")
      user_2 = User.create(id:2, username: "test name 2", password: "test123")

      Post.create(id:1, user_id: user_1.id ,message: "First post", image: nil)
      Post.create(id:2, user_id: user_2.id ,message: "Second post", image: nil)

      get :index

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show " do
    it "show a single post correctly" do
      user_1 = User.create(id:1, username: "test name 1", password: "test123")

      post = Post.create(id:1, user_id: user_1.id ,message: "First post", image: nil)

      get :show, params: { id: post.id }

      expect(post.message).to eq("First post")
      expect(response).to have_http_status(:success)
    end
  end
end
