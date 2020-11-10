class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_search, only: [:index]

  def index
    @posts = Post.all.order(id: :DESC).page(params[:page]).per(6)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
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

    @message = Message.new
    @messages = @post.messages.includes(:user)
    @users = PostUser.where(post_id: @post)
  end

  def chat_destroy
    post_user = PostUser.find_by(post_id: params[:id],user_id: current_user.id)
      if post_user.present?
        post_user.destroy
      end
    redirect_to root_path
  end

  def set_search
    @search = Post.ransack(params[:q])
  end

  def search
    @search = Post.ransack(params[:q])
    @posts = Post.where(prefectures_id: params[:q][:prefectures_id]).order(id: :DESC).page(params[:page]).per(6)
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :category_id, :description, :day_time, :prefectures_id, :place, :budget).merge(user_id: current_user.id)
  end

  # def search_post
  #   @p = Post.where(prefectures_id: params[:q][:prefectures_id])
  # end 

end
