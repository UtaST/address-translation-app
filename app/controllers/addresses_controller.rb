class AddressesController < ApplicationController
  
  def index
    @address = Address.new
  end

  def translate
    address = Address.new(address_params)
    render json: { address: address }
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :prefecture_code, :city, :house_number, :building_name, :room_number)
  end
end
