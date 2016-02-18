class CheckoutController < ApplicationController
  include Wicked::Wizard

  before_action :set_user
  before_action :set_order

  steps :billing, :shipping, :delivery, :payment, :confirm

  def show
    @user.billing
    @user.shipping
    @user.card
    render_wizard      
  end

  def update
    billing_step
    shipping_step
    delivery_step
    payment_step
    render_wizard @user
  end

  private

  def billing_step
    if step == :billing
      if @user.update(user_params) && !params[:shipping].nil?
        @order.address = @user.billing
        jump_to(:delivery)
      end
    end
  end

  def shipping_step
    if step == :shipping
      if @user.update(user_params)
        @order.address = @user.shipping
      end
    end
  end
  def delivery_step
    if step == :delivery
      @order.shipping = Shipping.find(params[:order][:shipping_id])
      @order.save
    end
  end
  def payment_step
    if step == :payment
      @user.update(card_params)
      @order.credit_card = @user.credit_card
      @order.save
    end
  end

  def set_user
    @user = current_user
  end

  def set_order
    @order = set_user.orders.find(params[:order_id])
  end

  def delivery_params
    params.require(:order).permit(:order => [:shipping_id])
  end
  def user_params
    params.require(:user).permit(:billing_address_attributes => [:firstname, :lastname, :address, :zipcode, :city, :phone, :country],
                                 :shipping_address_attributes => [:firstname, :lastname, :address, :zipcode, :city, :phone, :country])
  end
  def card_params
    params.require(:user).permit(:credit_card_attributes => [:id, :number, :expiration_month, :expiration_year, :cvv, :firstname, :lastname])
  end
end
