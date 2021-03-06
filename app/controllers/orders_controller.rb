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
    authorize! :show, @order
  end

  def update
    authorize! :update, @order
    if @order.queued!
      @order.total_price += @order.shipping.costs
      @order.completed_date = Time.now
      current_user.billing_address ||= @order.billing_address.dup
      current_user.shipping_address ||= @order.shipping_address.dup
      @order.save
      redirect_to order_path, notice: "Your order is completed."
    else 
      redirect_to order_checkout_path, alert: "Order state is invalid."
    end
  end

  private
  def set_order
    @order = Order.find(params[:id])
  end
end
