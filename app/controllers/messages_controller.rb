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
      render template: "posts/chat"
    else
      @messages = @post.messages.includes(:user)
      render template: "posts/chat"
    end
  end

  private
  def message_params
    params.require(:message).permit(:text).merge(user_id: current_user.id)
  end
end
