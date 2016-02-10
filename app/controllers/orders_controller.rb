class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :completed]

  # GET /orders
  # GET /orders.json
  def index
    if user_signed_in?
      @orders = current_user.orders.order(id: :desc).page(params[:page]).per(5)
    else
      redirect_to new_user_session_path, alert: 'You must sign in.'
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/1/edit
  def edit
  end

  def completed
    @order.complete
    @order.save
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
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
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = current_user.orders.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:shipping_id)
    end
end
