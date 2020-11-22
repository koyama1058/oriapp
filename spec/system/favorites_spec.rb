require 'rails_helper'

RSpec.describe "Favorites", type: :system do
  before do
    @post = FactoryBot.create(:post)
  end

  context "いいねできるとき" do
    it "ログインしたユーザーはいいねできる" do
      # ログインする
      visit new_user_session_path
      fill_in "user_email", with: @post.user.email
      fill_in "user_password", with: @post.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 投稿の詳細ページに遷移する
      visit post_path(@post)
      # 詳細ページにいいねボタンがあることを確認する
      expect(page).to have_content("いいね")
      # いいねボタンをクリックするとfavoliteテーブルのカラムが一つ増える
      expect{
        click_link 'いいね'
      }.to change { Favorite.count }.by(1)
      # 詳細ベージにいる
      expect(current_path).to eq post_path(@post)
      # いいねを外すボタンがあることを確認する
      expect(page).to have_content("いいねを外す")
    end
  end
      
  context 'いいねできないとき' do
    it 'ログインしていないといいねできない' do
      # トップページに遷移する
      visit root_path
      # 投稿の詳細ページに遷移しようとする
      visit post_path(@post)
      # 遷移できずにログインページに遷移する
      expect(current_path).to eq new_user_session_path
    end
  end
      
      
end
