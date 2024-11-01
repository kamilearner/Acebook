require_relative '../rails_helper.rb'

RSpec.describe FollowersController, type: :controller do

  before do
    # Create 2 Users
    @user1 = User.create(username: "Khari", password: "test123")
    @user2 = User.create(username: "Mauro", password: "test234")

    # Stimulating User1 logged in
    session[:user_id] = @user1.id
  end

  describe "GET #index" do
    it "responds with 200" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  # Create Relationship
  describe "POST #create" do
    # new relationship
    context "user is not already following other user" do
      it "creates a new follower relationship" do
        expect {
          post :create, params: { follower: {follower_id:@user1.id, followed_id: @user2.id } }
        }.to change(Follower, :count).by(1)

        # expectations
        expect(response).to have_http_status(:redirect)
        expect(flash[:message]).to eq("Successfully following")
      end
    end

    # prevents duplicate relationship
    context "user is already following other user" do
      it "does not create a duplicate relationship" do

        # attempt to follow
        expect {
          post :create, params: { follower: { followed_id: @user2.id } }
        }.to change(Follower, :count).by(1)

        # expectations
        expect {
          post :create, params: { follower: { followed_id: @user2.id } }
        }.not_to change(Follower, :count)

        expect(flash[:message]).to eq("You are already following this user.")

      end
    end
  end

  # Delete Relationship
  describe "DELETE #destroy" do
    it "destroys the follower relationship and responds with redirect" do
      follow = Follower.create(follower_id: @user1.id, followed_id: @user2.id)

      expect(follow).not_to be_nil
      expect(follow.id).not_to be_nil

      expect {
        delete :destroy, params: { id: @user2.id }
      }.to change(Follower, :count).by(-1)

      expect(response).to redirect_to(friends_path)
    end

    it "does not change the count if the follower relationship does not exist" do
      expect {
        delete :destroy, params: { id: -1 }
      }.not_to change(Follower, :count)

      expect(response).to redirect_to(friends_path)
    end

  end
end