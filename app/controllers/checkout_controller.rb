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
    case step
    when :billing
      @user.update(user_params)
      if !params[:shipping].nil?
        jump_to(:delivery)
        @order.address = @user.billing
        @order.save
      end
    when :shipping
      if @user.update(user_params)
        @order.address = @user.shipping
      end
    when :delivery
      @order.shipping = Shipping.find(params[:order][:shipping_id])
      @order.save
    when :payment
      @user.update(card_params)
      @order.credit_card = @user.credit_card
      @order.save
    end
    render_wizard @user
  end

  private
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
