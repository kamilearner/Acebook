class SessionsController < ApplicationController

  def index
  end

  def new
  end
  
  def home
  end

  def homepage
    if session[:user_id]
      redirect_to user_path(session[:user_id])
    else
      redirect_to login_path
    end
  end

  def create
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
      
    else
      message = "Something went wrong"
      redirect_to login_path, notice: message
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end