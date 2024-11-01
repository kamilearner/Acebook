class LikesController < ApplicationController


  def create
    # fetch user from session
    current_user = User.find(session[:user_id])

    # create new like instance, then build through association
    @like = current_user.likes.new(like_params)

    if !@like.save
      flash[:notice] = "Can't like!"
    end
    redirect_to @like.post
  end


  def destroy
    # fetch user from session
    current_user = User.find(session[:user_id])

    # find like to be destroyed
    @like = current_user.likes.find(params[:id])

    #reference post before destroying like
    post = @like.post

    @like.destroy
    redirect_to post
  end


  private
  def like_params
    params.require(:like).permit(:post_id)
  end
end
















=begin
 # find the correct post before adding like
  before_action :find_post

  # called before destroy method -- checks for correct post with likes
  before_action :find_like, only: [:destroy]

  # ------- LIKE
  # check if post has like aready in database
  # must match user_id & post_id -- before liking
  def create

    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @post.likes.create(user_id: session[:user_id])
    end
    redirect_to post_path(@post)
  end

  # ------- UNLIKE
  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
    redirect_to post_path(@post)
  end


  private

  # fetches post before performing likes
  def find_post
    @post = Post.find(params[:post_id])
  end

  # checks if user has already liked post
  def already_liked?

    Like.where(user_id: session[:user_id], post_id: params[:post_id]).exists?
  end

  # find like before being able to unlike
  def find_like
    @like = @post.likes.find(params[:id])
  end
=end
