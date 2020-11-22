class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.create(post_id: params[:post_id])
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.find_by(post_id: @post.id)
    if @favorite.destroy
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post)
    end
  end
end
