class MessagesController < ApplicationController

  def index
    @message = Message.new
    @post = Post.find(params[:post_id])
    @messages = @post.messages.includes(:user)
  end

  def create
    @post = Post.find(params[:post_id])
    @message = @post.messages.new(message_params)
    if @message.save
      redirect_to chat_post_path(@post.id)
    else
      @messages = @post.messages.includes(:user)
      redirect_to chat_post_path(@post.id)
    end
  end

  private
  def message_params
    params.require(:message).permit(:text, :image).merge(user_id: current_user.id)
  end
end
