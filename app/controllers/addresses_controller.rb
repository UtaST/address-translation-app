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
    params.require(:address).permit(:postal_code, :prefecture, :city, :town_name, :house_number, :building_name, :room_number)
  end

  def address_translation(address)
    require 'miyabi'
    require 'romaji/core_ext/string'
    # 「部屋番号」変換
    address.room_number.to_s.insert(0, '#')

    # 「建物名」変換
    en_building_name = address.building_name.to_kanhira.romaji.capitalize
    if en_building_name.match(/biru\z/) # 「〜ビル」の場合
      en_building_name[-4, 4] = '-building'
    elsif en_building_name.match(/manshon\z/) # 「〜マンション」の場合
      en_building_name.insert(-8, '-')
    elsif en_building_name.include?("apa-to") # 「〜アパート」の場合
      en_building_name[-6, 6] = '-apartment'
    end
    address.building_name = en_building_name # 頭文字を大文字に変換

    # 「町名」変換
    en_town_name = address.town_name.to_kanhira.romaji.capitalize
    address.town_name = en_town_name
    binding.pry

    # 「市区町村」変換
    city_len = address.city.length
    # 〇〇市〇〇区、〇〇郡〇〇町(村)の翻訳
    if address.city.include?("市") && address.city[-1] == "区" # 〇〇市〇〇区の場合true
      slice_point = address.city.index("市") 
      shi = address.city.slice!(0..slice_point) # 「〜市」と「〜区」を分離
      en_shi = shi.insert(-2, "-").to_kanhira.romaji.capitalize! # 〜市を英訳
      en_city = "#{en_shi} " + address.city.insert(-2, "-").to_kanhira.romaji.capitalize! # 〜区を英訳、統合
    elsif address.city[-1] == "町" || address.city[-1] == "村" # 〇〇郡〇〇町(村)の場合true
      slice_point = address.city.index("郡")
      gun = address.city.slice!(0..slice_point) # 「〜郡」と「〜町(村)」を分離
      en_gun = gun.insert(-2, "-").to_kanhira.romaji.capitalize! # 〜郡を英訳
      en_city = "#{en_gun} " + address.city.insert(-2, "-").to_kanhira.romaji.capitalize! # 〜町(村)を英訳、統合
    else # それ以外の翻訳
      en_city = address.city.insert(-2, "-").to_kanhira.romaji.capitalize!
    end
    address.city = en_city

    # 都道府県の翻訳
    unless address.prefecture == "北海道" # 北海道以外の場合true
      address.prefecture.insert(-2, "-") # 「県・府・都」の前に"-(ハイフン)"を挿入
    end
    en_prefecture = address.prefecture.to_kanhira.romaji.capitalize! # 翻訳
    address.prefecture = en_prefecture
  end
end
