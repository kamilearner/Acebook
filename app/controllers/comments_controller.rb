class CommentsController < ApplicationController
    def index 
        @comment = Comment.all
    end

    def new 
        @post = Post.find(params[:post_id])#find the post by postId params
        # user = session[:user_id]
        @comment = Comment.new(post_id: params[:post_id])# initialise a new comment for this post
        
    end

    def create 
        @post = Post.find(params[:post_id]) # ensure it is the correct post 
        @comment = @post.comments.build(comment_params)# Associate comment with post
        @comment.user_id = session[:user_id]#assign the user

        if @comment.save
            redirect_to post_path(@post)
        else
            redirect_to '/friends'
            # redirect_to post_path(@post) 
        end
    end



    private 

    def comment_params
        params.require(:comment).permit(:message_comment, :post_id)
    end
end
