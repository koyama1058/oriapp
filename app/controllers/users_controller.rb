class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # ユーザーが参加している投稿を取得
    @posts = PostUser.where(user_id: current_user).order(id: :DESC)
    # ユーザーがいいねした投稿を取得
    @favorites = Favorite.where(user_id: current_user).order(id: :DESC)
    # ユーザーに対するgood数を取得
    @goods = GoodUser.where(good_user_id: params[:id])
    # ユーザーに対するbad数を取得
    @bads = BadUser.where(bad_user_id: params[:id])
    # ユーザーが投稿したもの一覧
    @myposts = Post.where(user_id: current_user).order(id: :DESC)

    @good_user = GoodUser.find_by(good_user_id: params[:id], judge_user_id: current_user.id)

    @bad_user = BadUser.find_by(bad_user_id: params[:id], judge_user_id: current_user.id)
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
