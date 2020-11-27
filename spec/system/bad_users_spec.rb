require 'rails_helper'

RSpec.describe 'BadUsers', type: :system do
  before do
    @post = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end

  context 'bad_userできるとき' do
    it 'ログインしたユーザーはbad_userできる' do
      # ユーザー1でログインする
      visit new_user_session_path
      fill_in 'user_email', with: @post.user.email
      fill_in 'user_password', with: @post.user.password
      find('input[value="ログイン"]').click
      expect(current_path).to eq root_path
      # ユーザー2のが投稿した投稿詳細ページに遷移する
      visit post_path(@post2)
      # 投稿者の欄にリンクがあることを確認する
      expect(page).to have_content(@post2.user.nickname.to_s)
      # ユーザー2のユーザー詳細ページに遷移する
      visit user_path(@post2.user)
      # ユーザーを評価するbadボタンがあることを確認する
      expect(page).to have_content 'bad'
      # badボタンを押すとbad_userテーブルのカウントが1上がる
      expect do
        click_link 'bad'
      end.to change { BadUser.count }.by(1)
      # ユーザー2の詳細ページにいる
      expect(current_path).to eq user_path(@post2.user)
      # badを外すボタンがある
      expect(page).to have_content 'badを外す'
      # badを外すを押すとbad_userテーブルのカウントが1下がる
      expect do
        click_link 'badを外す'
      end.to change { BadUser.count }.by(-1)
    end

    it 'ログインしたユーザーはbad_userできて参加したチャット画面にアラートが現れる' do
      # ユーザー2でログインする
      visit new_user_session_path
      fill_in 'user_email', with: @post2.user.email
      fill_in 'user_password', with: @post2.user.password
      find('input[value="ログイン"]').click
      expect(current_path).to eq root_path
      # ユーザー2が投稿した投稿詳細ページに遷移する
      visit post_path(@post2)
      # 参加するボタンがあることを確認する
      expect(page).to have_content '参加する'
      # 参加するボタンを押すとpost_userテーブルのカウントが1上がる
      expect do
        click_link '参加する'
      end.to change { PostUser.count }.by(1)
      # ログアウトする
      click_link 'ログアウト'
      # ユーザー1でログインする
      visit new_user_session_path
      fill_in 'user_email', with: @post.user.email
      fill_in 'user_password', with: @post.user.password
      find('input[value="ログイン"]').click
      expect(current_path).to eq root_path
      # ユーザー2のが投稿した投稿詳細ページに遷移する
      visit post_path(@post2)
      # 投稿者の欄にリンクがあることを確認する
      expect(page).to have_content(@post2.user.nickname.to_s)
      # 参加するボタンをおすとpost_userテーブルのカウントが1上がる
      expect do
        click_link '参加する'
      end.to change { PostUser.count }.by(1)
      # チャット画面に遷移する
      expect(current_path).to eq chat_post_path(@post2)
      # bad_userをしていないためアラートは表示されていない
      expect(page).to have_no_content('bad評価したユーザーが含まれています')
      # ユーザー2のユーザー詳細ページに遷移する
      visit user_path(@post2.user)
      # ユーザーを評価するbadボタンがあることを確認する
      expect(page).to have_content 'bad'
      # badボタンを押すとbad_userテーブルのカウントが1上がる
      expect do
        click_link 'bad'
      end.to change { BadUser.count }.by(1)
      # ユーザー2の詳細ページにいる
      expect(current_path).to eq user_path(@post2.user)
      # 参加したチャットへ遷移する
      visit chat_post_path(@post2)
      # アラートが表示されている
      expect(page).to have_content('bad評価したユーザーが含まれています')
    end
  end

  context 'bad_userできないとき' do
    it '自分自身にはbad_userできない' do
      # ユーザー1でログインする
      visit new_user_session_path
      fill_in 'user_email', with: @post.user.email
      fill_in 'user_password', with: @post.user.password
      find('input[value="ログイン"]').click
      expect(current_path).to eq root_path
      # マイページに遷移する
      visit user_path(@post.user)
      # badボタンがない
      expect(page).to have_no_content('bad')
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
