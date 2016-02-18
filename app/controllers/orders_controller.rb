class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :completed]
  before_action :authenticate_user!

  def index
    if user_signed_in?
      @orders = current_user.orders.order(id: :desc).page(params[:page]).per(5)
      @in_progress = current_user.orders.where(aasm_state: 'in_progress').order(id: :desc)
      @in_queue = current_user.orders.where(aasm_state: 'in_queue').order(id: :desc)
      @delivered = current_user.orders.where(aasm_state: 'delivered').order(id: :desc)
    else
      redirect_to new_user_session_path, alert: 'You must sign in.'
    end
  end

  def show
    if @order.user != current_user
      redirect_to orders_path
    end
  end

  def completed
    if @order.queued!
      @order.total_price += @order.shipping.costs
      @order.save
      redirect_to order_path, notice: "Your order is completed."
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to edit_order_credit_card_path(@order), notice: "Order was successfully updated" }
      else
        format.html { render :address }
      end
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end
    
    def order_params
      params.require(:order).permit(:shipping_id)
    end

    def order_validate
      if @order.nil? || !@order.in_progress?
        redirect_to orders_path
      end
    end
end
