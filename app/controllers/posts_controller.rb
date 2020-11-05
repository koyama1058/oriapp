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
      @room = Room.create(post_id: @post.id)
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :category_id, :description, :day_time, :prefectures_id, :place, :budget).merge(user_id: current_user.id)
  end
end
