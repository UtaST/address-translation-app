class AddressesController < ApplicationController
  
  def index
    @address = User.find(current_user.id).address
  end
end
