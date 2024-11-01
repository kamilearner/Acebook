class PostsController < ApplicationController
  def new
    @post = Post.new
  end



  def create

    # created with params
    @post = Post.new(post_params)

    # added session to post
    @post.user_id = session[:user_id]

    # save! --- raises an error if fails
    if @post.save
      if params[:post][:image].present?
        # attach the image using ActiveStorage
        @post.image.attach(params[:post][:image])
      end
      redirect_to user_path(session[:user_id]), notice: 'Post created successfully'
    else
      render :new
    end
  end


  def index
    @posts = Post.all
  end


  def show
    @post= Post.find(params[:id])
    @comment = Comment.new
    @post.user_id = session[:user_id]
    render :show_post
  end


  def edit
    @post = Post.find(params[:id])
    if @post.user_id == session[:user_id]
      render :edit
    end
  end


  def update
    @post = Post.find(params[:id])
    if  @post.user_id = session[:user_id]
      if @post.update(post_params)
        redirect_to user_path(session[:user_id])

      else
        render :edit
      end
    end
  end


  def destroy
    @post = Post.find(params[:id])
    if @post.user_id == session[:user_id]
      @post.destroy
      redirect_to user_path(session[:user_id])
    end
  end


  private
  def post_params

    # permit -- needs to be symbols only & refers to form fields
    params.require(:post).permit(:message, :image)
  end
end
