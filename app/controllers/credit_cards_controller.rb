class CreditCardsController < ApplicationController
  before_action :set_card, only: [:edit, :update]

  def edit
    
  end

  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to edit_order_path(@card.orders.find(params[:order_id])), notice: "Order was successfully updated" }
      else
        format.html { render :edit }
      end
    end
  end

  private
  def card_params
    params.require(:credit_card).permit(:number, :cvv, :expiration_year, :expiration_month, :firstname, :lastname)
  end

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_card
    @card = CreditCard.where(:user => current_user).first_or_initialize
    @card.orders << set_order
  end
end
