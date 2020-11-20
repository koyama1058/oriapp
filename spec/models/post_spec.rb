require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    binding.pry
    @post = FactoryBot.build(:post)
    
  end

  describe '新規投稿' do
    context '新規登録がうまくいくとき' do
      it '全て入力されていれば登録できる' do
        expect(@post).to be_valid
      end
    end

    # context '新規投稿がうまくいかない時' do
    #   it "imageが空だと登録できない" do
    #     @post.image = nil
    #     @post.valid?
    #     binding.pry
    #     expect(@post.errors.full_messages).to include("Image can't be blank")
    #   end

    #   it "titleが空だと登録できない" do
    #     @post.title = nil
    #     @post.valid?
    #     expect(@post.errors.full_messages).to include("Title can't be blank")
    #   end

    #   it "category_idが空だと登録できない" do
    #     @post.category_id = nil
    #     @post.valid?
    #     expect(@post.errors.full_messages).to include("Category can't be blank")
    #   end

    #   it "category_idが数字以外だと登録できない" do
    #     @post.category_id = "a"
    #     @post.valid?
    #     expect(@post.errors.full_messages).to include("Category is not a number")
    #   end


    #   it "descriptionが空だと登録できない" do
    #     @post.description = nil
    #     @post.valid?
    #     expect(@post.errors.full_messages).to include("Description can't be blank")
    #   end

    #   it "day_timeが空だと登録できない" do
    #     @post.day_time = nil
    #     @post.valid?
    #     expect(@post.errors.full_messages).to include("Day time can't be blank")
    #   end

    #   it "prefectures_idが空だと登録できない" do
    #     @post.prefectures_id = nil
    #     @post.valid?
    #     expect(@post.errors.full_messages).to include("Prefectures can't be blank")
    #   end

    #   it "placeが空だと登録できない" do
    #     @post.place = nil
    #     @post.valid?
    #     expect(@post.errors.full_messages).to include("Place can't be blank")
    #   end

    #   it "budgetが空だと登録できない" do
    #     @post.budget = nil
    #     @post.valid?
    #     expect(@post.errors.full_messages).to include("Budget can't be blank")
    #   end

    #   it "category_idが1だと登録できない" do
    #     @post.category_id = 1
    #     @post.valid?
    #     expect(@post.errors.full_messages).to include("Category must be other than 1")
    #   end

    # end
  end
end