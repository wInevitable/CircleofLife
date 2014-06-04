class PostsController < ApplicationController
  def new
    @post = Post.new
    @user = current_user
    @circles = @user.circles
  end
  
  
  def create
    @post = current_user.posts.new(post_params)

    link_params.each do |k|
      @post.links.new(url: k[:url])
    end

    if @post.save
      redirect_to user_url(current_user)
    else
      @user = current_user
      @circles = @user.circles
      flash.now[:alert] = @post.errors.full_messages
      render :new
    end
  end
  
  def show
    @user = current_user
    @posts = @user.incoming_posts
  end
  
  private
  
  def post_params
    params.require(:post).permit(:body, circle_ids: [])
  end
  
  def link_params
    params.require(:links).values
  end
end
