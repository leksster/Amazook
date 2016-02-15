class AddressesController < ApplicationController
  before_action :set_billing_address, only: [:edit, :update, :editshipping, :addshipping]
  before_action :set_order, only: [:edit, :editshipping, :addshipping, :update]
  before_action :set_shipping_address, only: [:addshipping, :editshipping, :update]

  def edit
  end

  def update
    respond_to do |format|
      if params[:shipping].nil?
        format.html { render :editshipping }
      elsif @billing.update(billing_params)
        @order.address = @billing
        format.html { redirect_to user_order_shippings_path(current_user, @order), notice: "Order was successfully updated" }
      else
        format.html { render :edit }
      end
    end
  end

  def addshipping
    respond_to do |format|
      if @shipping.update(shipping_params)
        @order.address = @shipping
        format.html { redirect_to user_order_shippings_path, notice: "Order was successfully updated" }
      else
        format.html { render :editshipping }
      end
    end
  end

  def editshipping
  end

  private
  def billing_params
    params.require(:billing_address).permit(:firstname, :lastname, :address, :zipcode, :city, :phone, :country)
  end

  def shipping_params
    params.require(:shipping_address).permit(:firstname, :lastname, :address, :zipcode, :city, :phone, :country)
  end
  def set_billing_address
    @billing = current_user.billing
  end

  def set_shipping_address
    @shipping = current_user.shipping
  end

  def set_order
    @order = Order.find(params[:order_id])
  end
end
