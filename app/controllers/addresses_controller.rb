class AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update, :editshipping, :addshipping]
  before_action :set_order, only: [:edit, :editshipping, :addshipping, :update]
  before_action :set_shipping_address, only: [:addshipping, :editshipping, :update]

  def edit
    @order = Order.find(params[:order_id])
  end

  def update
    respond_to do |format|
      if params[:shipping].nil?
        format.html { render :editshipping }
      elsif @address.update(address_params)
        @order.address = @address
        format.html { redirect_to user_order_shippings_path, notice: "Order was successfully updated" }
        #format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        #format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def addshipping
    respond_to do |format|
      if @shipping_address.update(address_params)
        format.html { redirect_to user_order_shippings_path, notice: "Order was successfully updated" }
        #format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :editshipping }
        #format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def editshipping
  end

  private
  def address_params
    params.require(:address).permit(:address, :zipcode, :city, :phone, :country)
  end

  def set_address
    @address = Address.where(:user => current_user).first_or_initialize
  end

  def set_shipping_address
    @shipping_address = Address.where(:order => set_order, :user => nil).first_or_initialize
  end

  def set_order
    @order = Order.find(params[:order_id])
  end
end
