class AddressesController < ApplicationController
  
  def index
    @address = Address.new
  end

  def translate
    address = Address.new(address_params)
    address_translation(address)
    render json: { address: address }
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :prefecture, :city, :house_number, :building_name, :room_number)
  end

  def address_translation(address)
    require 'kakasi'
    # 「部屋番号」変換
    address.room_number.to_s.insert(0, '#')

    # 「建物名」変換
    en_building_name = Kakasi.kakasi('-Ja -Ha -Ka', address.building_name)
    if en_building_name.match(/biru\z/) # 「〜ビル」の場合
      en_building_name[-4, 4] = '-building'
    elsif en_building_name.match(/manshon\z/) # 「〜マンション」の場合
      en_building_name.insert(-8, '-')
    elsif en_building_name.match(/apa^to\z/) # 「〜アパート」の場合
      en_building_name[-6, 6] = '-apartment'
    end
    address.building_name = en_building_name.capitalize! # 頭文字を大文字に変換

    # 「町名・番地・号」変換
    en_house_number = Kakasi.kakasi('-Ja -Ha -Ka', address.house_number).capitalize!
    en_house_number_len = en_house_number.length # 翻訳した町名・番地・号の文字数
    en_house_number_len.times do |i|
      if en_house_number[i].match(/[a-z]/i) && en_house_number[i + 1].match(/\d/) # 「丁目・番地・号」部分と「町名」部分を分離、順番入れ替え
        house_number_num = en_house_number.slice!((i + 1)..-1) # 分離した「丁目・番地・号」
        en_house_number.insert(0, "#{house_number_num} ") # 「丁目・番地・号」を「町名」の前に挿入
      end
    end
    address.house_number = en_house_number

    # 「市区町村」変換
    city_len = address.city.length
    # 〇〇市〇〇区、〇〇郡〇〇町(村)の翻訳
    if address.city.include?("市") && address.city[-1] == "区" # 〇〇市〇〇区の場合true
      slice_point = address.city.index("市") 
      shi = address.city.slice!(0..slice_point) # 「〜市」と「〜区」を分離
      en_shi = Kakasi.kakasi('-Ja -Ha -Ka', shi.insert(-2, "-")).capitalize! # 〜市を英訳
      en_city = Kakasi.kakasi('-Ja -Ha -Ka', address.city.insert(-2, "-")).capitalize! + " #{en_shi}" # 〜区を英訳、統合
    elsif address.city[-1] == "町" || address.city[-1] == "村" # 〇〇郡〇〇町(村)の場合true
      slice_point = address.city.index("郡")
      gun = address.city.slice!(0..slice_point) # 「〜郡」と「〜町(村)」を分離
      en_gun = Kakasi.kakasi('-Ja -Ha -Ka', gun.insert(-2, "-")).capitalize! # 〜郡を英訳
      en_city = Kakasi.kakasi('-Ja -Ha -Ka', address.city.insert(-2, "-")).capitalize! + " #{en_gun}" # 〜町(村)を英訳、統合
    else # それ以外の翻訳
      en_city = Kakasi.kakasi('-Ja -Ha -Ka', address.city.insert(-2, "-")).capitalize!
    end
    address.city = en_city

    # 都道府県の翻訳
    unless address.prefecture == "北海道" # 北海道以外の場合true
      address.prefecture.insert(-2, "-") # 「県・府・都」の前に"-(ハイフン)"を挿入
    end
    en_prefecture = Kakasi.kakasi('-Ja -Ha -Ka', address.prefecture).capitalize! # 翻訳
    address.prefecture = en_prefecture
  end
end
