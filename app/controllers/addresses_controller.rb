class AddressesController < ApplicationController
  
  def index
    @address = Address.new
  end

  def show
    @address = Address.find_by(user_id: current_user.id)
    TranslateAddressesService.translate(@address)
    @en_address = @address
    @en_city = @en_address.city.split(' ')
    @address = Address.find_by(user_id: current_user.id)
  end

  def translate
    address = Address.new(address_params)
    TranslateAddressesService.translate(address)
    render json: { address: address }
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :prefecture, :city, :town_name, :house_number, :building_name, :room_number)
  end
end
