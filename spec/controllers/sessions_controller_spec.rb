require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #login form " do
    it "responds with 200" do
      get :login
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #login form " do
    it "responds with 200" do
        post :login, params: {session: {username: 'test_name', password: 'test_password'}}
        expect(response).to have_http_status(:success)
      end
  end

  describe "GET #homepage" do
    it "when user is logged in redirects to the user homepage" do
      user = User.create(username: "test", password: "test")
      session[:user_id] = user.id
        get :homepage
        expect(response).to redirect_to(user_path(user.id))
      end
  end

  describe "GET #homepage" do
    it "when user is not logged in redirects to the login page" do
        get :homepage
        expect(response).to redirect_to(login_path)
      end
  end

  describe "POST #create" do
    it "with valid credential user is created" do
      user = User.create!(username: "testuser", password: "password")
      post :create, params: { username: "testuser", password: "password" }
      expect(session[:user_id]).to eq(user.id)
      expect(response).to redirect_to(user_path(user.id))
      end
  end

  describe "DELETE #destroy" do
    it "account is deleted successfully" do
      user = User.create(id: 1, username: 'test name', password: 'test')
      session[:user_id] = user.id
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end

end
