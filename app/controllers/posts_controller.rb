class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      # @room = Room.create(post_id: @post.id)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
    # @room = Room.find_by(post_id: @post.id)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  def chat
    post_user = PostUser.new(post_id: params[:id],user_id: current_user.id)
    if PostUser.where(post_id: params[:id],user_id: current_user.id) == []
      post_user.save
    end
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :category_id, :description, :day_time, :prefectures_id, :place, :budget).merge(user_id: current_user.id)
  end

end
