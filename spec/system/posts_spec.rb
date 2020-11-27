require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post)
  end

  context '投稿できるとき' do
    it 'ログインしたユーザーは投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[value="ログイン"]').click
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('新規投稿')
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      attach_file 'posts_tag_image', 'app/assets/images/image.png'
      fill_in 'posts_tag_title', with: @post.title
      fill_in 'posts_tag_description', with: @post.description
      fill_in 'posts_tag_day_time', with: @post.day_time
      fill_in 'posts_tag_place', with: @post.place
      fill_in 'posts_tag_budget', with: @post.budget
      select '陶芸', from: 'posts_tag_category_id'
      select '北海道', from: 'posts_tag_prefectures_id'
      fill_in 'posts_tag_name', with: 'タグ テスト'
      fill_in 'posts_tag_address', with: '東京都'
      # 送信するとpost.spot.tagモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Post.count }.by(1)
      # トップページに遷移する
      visit root_path
      # スクロールして投稿の欄まで遷移する
      execute_script('window.scrollBy(0,10000)')
      # トップページには先ほど投稿した内容の投稿が存在することを確認する（テキスト）
      expect(page).to have_content(@post.title)
    end
  end

  context '投稿が保存できないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('新規投稿')
    end
  end
end

RSpec.describe '投稿編集', type: :system do
  before do
    @post = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end

  context '投稿が編集できるとき' do
    it 'ログインしたユーザーは自分の投稿を編集できる' do
      # 投稿1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user_email', with: @post.user.email
      fill_in 'user_password', with: @post.user.password
      find('input[value="ログイン"]').click
      expect(current_path).to eq root_path
      # 投稿1の詳細画面に遷移する
      visit post_path(@post)
      # 投稿1にの詳細画面「編集」ボタンがあることを確認する
      expect(page).to have_content('編集')
      # 編集ページへ遷移する
      visit edit_post_path(@post)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#post_title').value
      ).to eq @post.title
      expect(
        find('#post_description').value
      ).to eq @post.description
      expect(
        find('#post_day_time').value
      ).to eq @post.day_time
      expect(
        find('#post_place').value
      ).to eq @post.place
      expect(
        find('#post_budget').value
      ).to eq @post.budget
      expect(
        find('#post_category_id').value
      ).to eq '3'
      expect(
        find('#post_prefectures_id').value
      ).to eq '3'
      # 投稿内容を編集する
      fill_in 'post_title', with: '編集テスト'
      fill_in 'post_description', with: '編集テスト'
      fill_in 'post_day_time', with: '編集テスト'
      fill_in 'post_place', with: '編集テスト'
      fill_in 'post_budget', with: '編集テスト'
      select 'ガラス細工', from: 'post_category_id'
      select '宮城県', from: 'post_prefectures_id'
      fill_in 'post_name', with: 'タグ テスト'
      # 編集ボタンをクリックする
      find('input[name="commit"]').click
      # トップページに遷移する
      expect(current_path).to eq root_path
      # スクロールして投稿の欄まで遷移する
      execute_script('window.scrollBy(0,10000)')
      # トップページには先ほど変更した内容の投稿が存在するこを確認
      expect(page).to have_content('編集テスト')
    end
  end

  context '投稿の編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したものの編集画面に遷移できない' do
      # 投稿1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user_email', with: @post.user.email
      fill_in 'user_password', with: @post.user.password
      find('input[value="ログイン"]').click
      expect(current_path).to eq root_path
      # 投稿2の詳細画面に遷移する
      visit post_path(@post2)
      # 投稿2の詳細画面「編集」ボタンがあることを確認する
      expect(page).to have_no_content('編集')
    end

    it 'ログインしていないと投稿の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 編集画面に遷移する
      visit post_path(@post2)
      # ログイン画面に戻される
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe '投稿削除', type: :system do
  before do
    @post = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end

  context '投稿の削除ができるとき' do
    it 'ログインしたユーザーは自分が投稿した投稿の削除ができる' do
      # 投稿1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user_email', with: @post.user.email
      fill_in 'user_password', with: @post.user.password
      find('input[value="ログイン"]').click
      expect(current_path).to eq root_path
      # 投稿1の詳細画面に遷移する
      visit post_path(@post)
      # 投稿1にの詳細画面「削除」ボタンがあることを確認する
      expect(page).to have_content('削除')
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect do
        find_link('削除', href: post_path(@post)).click
      end.to change { Post.count }.by(-1)
      # トップページに遷移する
      expect(current_path).to eq root_path
      # トップページには先ほど変更した内容の投稿が存在しないことを確認する
      expect(page).to have_no_content(@post.title.to_s)
    end
  end

  context '投稿の削除ができない' do
    it 'ログインしたユーザーは自分以外が投稿した投稿の削除ができない' do
      # 投稿1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user_email', with: @post.user.email
      fill_in 'user_password', with: @post.user.password
      find('input[value="ログイン"]').click
      expect(current_path).to eq root_path
      # 投稿2の詳細画面に遷移する
      visit post_path(@post2)
      # 投稿2にの詳細画面「削除」ボタンがないことを確認する
      expect(page).to have_no_content('削除')
    end

    it 'ログインしていないと投稿の削除には遷移できない' do
      # トップページにいる
      visit root_path
      # 編集画面に遷移する
      visit post_path(@post2)
      # ログイン画面に戻される
      expect(current_path).to eq new_user_session_path
    end
  end
end
