class CheckoutController < ApplicationController
  include Wicked::Wizard

  before_action :set_user
  before_action :set_order
  before_action :valid_order

  steps :billing, :shipping, :delivery, :payment, :confirm

  def show
    @order.build_or_find_billing_address(@user)
    @order.build_or_find_shipping_address(@user)
    @order.build_or_find_credit_card(@user)
    render_wizard      
  end

  def update
    case step
    when :billing
      if @order.update(order_params) && !params[:shipping].nil?
        @order.build_shipping_address.attributes = @order.billing_address.attributes.except("id", "type", "user_id")
        jump_to(:delivery)
      end
    when :shipping
      @order.update(order_params)
    when :delivery
      @order.shipping = Shipping.find(params[:order][:shipping_id])
    when :payment
      @order.update(order_params)
    end
    render_wizard @order
  end

  private

  def valid_order
    redirect_to order_path(@order) unless @order.in_progress?
  end

  def set_user
    @user = current_user
  end

  def set_order
    @order = set_user.orders.find(params[:order_id])
  end

  def order_params
    params.require(:order).permit(:billing_address_attributes  => [:firstname, :lastname, :address, :zipcode, :city, :phone, :country],
                                  :shipping_address_attributes => [:firstname, :lastname, :address, :zipcode, :city, :phone, :country],
                                  :credit_card_attributes      => [:number, :expiration_month, :expiration_year, :cvv, :firstname, :lastname],
                                  :order                       => [:shipping_id])
  end
end
