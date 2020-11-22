require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'チャット機能' do
    context 'チャットが投稿できるとき' do
      it 'textとimageが入力されていると投稿できる' do
        expect(@message).to be_valid
      end

      it 'textが入力されていると投稿できる' do
        @message.image = nil
        expect(@message).to be_valid
      end

      it 'imageが入力されていると投稿できる' do
        @message.text = nil
        expect(@message).to be_valid
      end
    end

    context 'チャット投稿がうまくいかない時' do
      it 'textとimageの両方が空だと投稿できない' do
        @message.image = nil
        @message.text = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Text can't be blank")
      end
      it 'postが紐付いていないと保存できないこと' do
        @message.post = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('Post must exist')
      end
      it 'userが紐付いていないと保存できないこと' do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('User must exist')
      end
    end
  end
end
