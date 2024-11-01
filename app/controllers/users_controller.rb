class UsersController < ApplicationController

  def index
    @users = User.all

    following_ids = Follower.where(follower_id: session[:user_id]).pluck(:followed_id)
    # p "###### #{following_ids}"
    @following_users = User.where(id: following_ids).pluck(:username, :id)
  end

  # GET '/register', to: 'users#register'
  def new
    @user = User.new
  end


  # POST '/register', to: 'users#create'
  def create
    @user = User.new(user_params)

    if @user.save

      # get user id
      session[:user_id] = @user.id

      # get username
      session[:username] = @user.username

      redirect_to user_path(@user.id)

    else
      render :new
    end
  end

  # GET '/users/:id', to: "users#show"
  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).order(created_at: :desc)
  end

  def destroy
    p 'account deleted'
    @user = User.find(params[:id])
    if @user.id == session[:user_id] && @user.destroy
      flash[:notice] = "Your account has been deleted."
      session[:user_id] = nil # Clear the session
      redirect_to root_path # Redirect to the home page or login page
    else
      flash[:alert] = "There was a problem deleting your account."
      redirect_to user_path(@user)
    end
  end


  private
  def user_params
    # permit only -- takes only the parameters
    # require, permit -- takes user object first, then parameters within object -- object not created yet so user is empty
    params.permit(:username, :password)
  end

end