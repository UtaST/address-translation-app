require 'rails_helper'

RSpec.describe Address, type: :model do
  describe '住所情報登録' do
    before do
      @address = FactoryBot.build(:address)
    end

    it '全ての値が正しく入力されていれば登録できること' do
      expect(@address).to be_valid
    end

    it '郵便番号が入力されていないと登録できないこと' do
      @address.postal_code = nil
      @address.valid?
      expect(@address.errors.full_messages).to include '郵便番号を入力してください'
    end

    it '郵便番号が正しく入力(xxx-xxxx)されていないと登録できないこと' do
      @address.postal_code = 3333333
      @address.valid?
      expect(@address.errors.full_messages).to include '郵便番号を正しく入力してください'
    end

    it '都道府県が入力されていないと登録できないこと' do
      @address.prefecture = nil
      @address.valid?
      expect(@address.errors.full_messages).to include '都道府県を入力してください'
    end

    it '市区町村が入力されていないと登録できないこと' do
      @address.city = nil
      @address.valid?
      expect(@address.errors.full_messages).to include '市区町村を入力してください'
    end

    it '番地・号が入力されていないと登録できないこと' do
      @address.house_number = nil
      @address.valid?
      expect(@address.errors.full_messages).to include '番地・号を入力してください'
    end
  end
end
