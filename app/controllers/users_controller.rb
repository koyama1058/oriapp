class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.new(user_params)
    if current_user.update(user_params)
      redirect_to root_path
    else
      render action: :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:image, :nickname, :email, :introduction, :job_id, :hobby, :prefectures_id, :gender_id, :birthday)
  end
end