    require 'rails_helper'

    RSpec.describe CommentsController, type: :controller do


        describe "GET #index" do
    it "renders the index template with all the comments" do
        user_1 = User.create(id: 1, username: "test name 1", password: "test123")
        post_1 = Post.create(id: 1, user_id: user_1.id, message: "First post", image: nil)

        Comment.create(id: 1, post_id: post_1.id, user_id: user_1.id, message_comment: "First comment")

        # Pass post_id in the params to match the route
        get :index, params: { post_id: post_1.id }

        expect(response).to have_http_status(:success)
        end
    end

        describe "GET #new" do
            it "responds with 200" do
                user = User.create(id: 1, username: 'testuser', password: 'testpassword')
                session[:user_id] = user.id
                post_record = Post.create(id: 1, user_id: user.id, message: "Hello, world!")
                
                get :new, params: { post_id: post_record.id }
                expect(response).to have_http_status(:success)
            end
        end

    

    describe "POST #create" do
        it "creates a comment and redirects to the post" do
        user = User.create(id: 1, username: 'testuser', password: 'testpassword')
        session[:user_id] = user.id
        post_record = Post.create(id: 1, user_id: user.id, message: "Hello, world!")

        expect {
            post :create, params: {
            post_id: post_record.id,
            comment: { message_comment: "Great post!", post_id: post_record.id }
            }
        }.to change(Comment, :count).by(1)

        comment = Comment.last

        expect(response).to redirect_to(post_path(post_record))
        expect(response).to have_http_status(302)
        expect(comment.message_comment).to eq("Great post!")
        expect(comment.user_id).to eq(user.id)
        end
    end

    describe "POST /" do
        it "does not create a comment when message_comment is nil" do
        user = User.create(id: 1, username: 'testuser', password: 'testpassword')
        post_record = Post.create(id: 1, user_id: user.id, message: "Hello, world!")
        session[:user_id] = user.id

        # Try to create a comment with invalid attributes (message_comment: nil)
        post :create, params: { post_id: post_record.id, comment: { message_comment: nil, post_id: post_record.id } }

        # Ensure the comment has not been saved to the database
        expect(Comment.find_by(post_id: post_record.id, message_comment: nil)).to be_nil
        expect(response).to redirect_to('/friends')
        end
    end
    end

