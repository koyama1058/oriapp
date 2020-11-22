require 'rails_helper'

RSpec.describe "GoodUsers", type: :system do
  before do
    @post = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end

  context "good_userできるとき" do
    it "ログインしたユーザーはgood_userできる" do
      # ユーザー1でログインする
      visit new_user_session_path
      fill_in "user_email", with: @post.user.email
      fill_in "user_password", with: @post.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # ユーザー2のが投稿した投稿詳細ページに遷移する
      visit post_path(@post2)
      # 投稿者の欄にリンクがあることを確認する
      expect(page).to have_content("#{@post2.user.nickname}")
      # ユーザー2のユーザー詳細ページに遷移する
      visit user_path(@post2.user)
      # ユーザーを評価するgoodボタンがあることを確認する
      expect(page).to have_content 'good'
      # goodボタンを押すとgood_userテーブルのカウントが1上がる
      expect{
        click_link 'good'
      }.to change { GoodUser.count }.by(1)
      # ユーザー2の詳細ページにいる
      expect(current_path).to eq user_path(@post2.user)
      # goodを外すボタンがある
      expect(page).to have_content 'goodを外す'
      # goodを外すを押すとgood_userテーブルのカウントが1下がる
      expect{
        click_link 'goodを外す'
      }.to change { GoodUser.count }.by(-1)
    end
  end
      
  context 'good_userできないとき' do
    it '自分自身にはgood_userできない' do
      # ユーザー1でログインする
      visit new_user_session_path
      fill_in "user_email", with: @post.user.email
      fill_in "user_password", with: @post.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # マイページに遷移する
      visit user_path(@post.user)
      # goodボタンがない
      expect(page).to have_no_content("good")
    end

    it 'ログインしていないといいねできない' do
      # トップページに遷移する
      visit root_path
      # 投稿の詳細ページに遷移しようとする
      visit post_path(@post2)
      # 遷移できずにログインページに遷移する
      expect(current_path).to eq new_user_session_path
    end
  end
end
