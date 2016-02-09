class CreditCardsController < ApplicationController
  before_action :set_card, only: [:edit, :update]

  def edit
    
  end

  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to edit_user_order_path(current_user, @card.orders.find(session[:order])), notice: "Order was successfully updated" }
        #format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        #format.json { render json: @order.errors, status: :unprocessable_entity }
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
