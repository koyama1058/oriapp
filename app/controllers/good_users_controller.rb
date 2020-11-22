class GoodUsersController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @good_user = GoodUser.create(good_user_id: params[:user_id], judge_user_id: current_user.id)
    redirect_to  user_path(@user)
  end

  def destroy
    @user = User.find(params[:user_id])
    @good_user = GoodUser.find_by(good_user_id: params[:user_id], judge_user_id: current_user.id)
    if @good_user.destroy
      redirect_to  user_path(@user)
    else
      redirect_to  user_path(@user)
    end
  end
end
