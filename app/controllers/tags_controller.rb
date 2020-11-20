class TagsController < ApplicationController

  def show
    @posts = PostTag.where(tag_id: params[:id])
  end

end
