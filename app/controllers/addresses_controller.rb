class AddressesController < ApplicationController
  
  def index
    if user_signed_in?
      @address = User.find(current_user.id).address
    end
  end
end
