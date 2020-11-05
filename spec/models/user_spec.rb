require 'rails_helper'

  RSpec.describe User, type: :model do
    before do
      @user = FactoryBot.build(:user)
    end

  describe '新規登録' do
      it 'ニックネームとメール、パスワードが入力されていれば登録できる' do
      expect(@user).to be_valid
      end

    context '新規登録がうまくいかない時' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空だと登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'passwordが空だと登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'password_confirmationが空だと登録できない' do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordとpassword_confirmationが違うと登録できない' do
        @user.password_confirmation = "564879"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'emailが登録済みのものだと登録できない' do
        user = FactoryBot.create(:user)
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end
    end

  end
end
