require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    it '全ての値が正しく入力されていれば保存できること' do
      expect(@user).to be_valid
    end

    it 'nicknameが空だと登録できないこと' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "ニックネームを入力してください"
    end

    it 'emailが空だと登録できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "Eメールを入力してください"
    end

    it 'emailに@が含まれていないと登録できないこと' do
      @user.email = "hoge"
      @user.valid?
      expect(@user.errors.full_messages).to include "Eメールは不正な値です"
    end
    
    it 'emailが重複した場合登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include "Eメールはすでに存在します"
    end

    it 'passwordが空だと登録できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include "パスワードを入力してください"
    end

    it 'passwordが五文字以下だと登録できないこと' do
      @user.password = "123ab"
      @user.valid?
      expect(@user.errors.full_messages).to include "パスワードは6文字以上で入力してください"
    end

    it 'passwordは半角英数字混合でないと登録できないこと' do
      @user.password = "123456"
      @user.valid?
      expect(@user.errors.full_messages).to include "パスワードは半角英数字をそれぞれ一文字以上使用してください"
    end

    it 'passwordが存在してもpassword_confirmationが空だと登録できないこと' do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
    end
  end
end
