class AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update]

  def edit
    
  end

  def update
    respond_to do |format|
      if current_user.address.update(address_params)
        format.html { redirect_to shippings_path, notice: "Order was successfully updated" }
        #format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        #format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def address_params
    params.require(:address).permit(:address, :zipcode, :city, :phone, :country)
  end
  def set_address
    @address = Address.find_or_initialize_by(:user => current_user)
  end

end
