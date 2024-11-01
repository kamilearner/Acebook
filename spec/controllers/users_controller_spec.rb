require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #index " do
    it "responds with 200" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #register " do
    it "responds with 200" do
      get :register
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show " do
    it "responds with 200" do
      user = User.create(id:1, username: "test name", password: "test123")
      get :show, params: {id: user.id}
      expect(response).to have_http_status(:success)
    end
  end
end
