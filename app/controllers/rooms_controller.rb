class RoomsController < ApplicationController

  def index
    # post_idはroom_idのこと
    room_user = RoomUser.new(room_id: params[:post_id],user_id: current_user.id)
    if RoomUser.where(room_id: params[:post_id],user_id: current_user.id) == []
      room_user.save
    end
    @message = Message.new
    # post_idはroom_idのこと
    @room = Room.find(params[:post_id])
  end


end
