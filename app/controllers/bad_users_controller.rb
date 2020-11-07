class BadUsersController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @bad_user = BadUser.create(user_id: params[:user_id])
    redirect_to  user_path(@user)
  end

  def destroy
    @user = User.find(params[:user_id])
    @bad_user = BadUser.find_by(user_id: params[:user_id])
    if @bad_user.destroy
      redirect_to  user_path(@user)
    else 
      redirect_to  user_path(@user)
    end
  end
end
