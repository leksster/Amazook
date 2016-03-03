class CheckoutController < ApplicationController

  include Wicked::Wizard
  before_action :authenticate_user!
  before_action :set_order

  steps :billing, :shipping, :delivery, :payment, :confirm

  def show
    authorize! :edit, @order
    case step
    when :delivery
      jump_to(:billing) if @order.shipping_address.nil?
    when :payment
      jump_to(:delivery) if @order.shipping.nil?
    when :confirm
      jump_to(:payment) if @order.credit_card.nil?
    end
    @order.build_or_find_billing_address(current_user)
    @order.build_or_find_shipping_address(current_user)
    @order.build_or_find_credit_card(current_user)
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

  def set_order
    @order = Order.find(params[:order_id])
  end

  def order_params
    params.require(:order).permit(:billing_address_attributes  => [:firstname, :lastname, :address, :zipcode, :city, :phone, :country],
                                  :shipping_address_attributes => [:firstname, :lastname, :address, :zipcode, :city, :phone, :country],
                                  :credit_card_attributes      => [:number, :expiration_month, :expiration_year, :cvv, :firstname, :lastname],
                                  :order                       => [:shipping_id])
  end
end
