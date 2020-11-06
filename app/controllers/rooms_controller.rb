class RoomsController < ApplicationController

  def index
    room_user = RoomUser.new(room_id: params[:post_id],user_id: current_user.id)
    if RoomUser.where(room_id: params[:post_id],user_id: current_user.id) == []
      room_user.save
    end
  end


end
