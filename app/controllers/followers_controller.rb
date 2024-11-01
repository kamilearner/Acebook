class FollowersController < ApplicationController
  def index
  end

  def create()

    followed_id = params[:follower][:followed_id]
    @relationship = Follower.new(follower_id: session[:user_id], followed_id: followed_id)

    if Follower.exists?(follower_id: session[:user_id], followed_id: followed_id)
      flash[:message] = "You are already following this user."
      # p 'you alredy follow this user'
    elsif @relationship.save
        flash[:message] = "Successfully following"
        redirect_to "/friends"
    else
        flash[:message] = "Unsucessful"
        redirect_to "/friends"
    end

  end

  def destroy
    following = Follower.find_by(follower_id: session[:user_id], followed_id: params[:id])
    # following = Follower.find_by(id: params[:id], follower_id: session[:user_id])

    if following
      following.destroy
    end

    redirect_to friends_path
  end
end
