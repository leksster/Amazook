class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :completed]

  def index
    if user_signed_in?
      @orders = current_user.orders.order(id: :desc).page(params[:page]).per(5)
    else
      redirect_to new_user_session_path, alert: 'You must sign in.'
    end
  end

  def show
  end

  def edit
  end

  def completed
    if @order.complete!
      @order.total_price += @order.shipping.costs
      @order.save
      redirect_to user_order_path, notice: "Your order is completed."
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to edit_user_order_credit_card_path(current_user, @order), notice: "Order was successfully updated" }
        #format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :address }
        #format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_order
      @order = current_user.orders.find(params[:id])
    end
    
    def order_params
      params.require(:order).permit(:shipping_id)
    end

    def order_validate
      if @order.nil? || !@order.in_progress?
        redirect_to user_orders_path
      end
    end
end
