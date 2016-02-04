class OrdersController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update, :destroy, :delivery, :address]

  # GET /orders
  # GET /orders.json
  def index
    if user_signed_in?
      @orders = current_user.orders
    else
      redirect_to new_user_session_path, alert: 'You must sign in.'
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  def address
  end

  # GET /orders/1/delivery
  def delivery
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html do 
          if request.referer.include?('address')
            redirect_to delivery_order_path(@order), notice: "Order was successfully updated"
          elsif request.referer.include?('delivery')
            redirect_to @order, notice: 'Order was successfully updated2.'
          end
        end
        #format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :address }
        #format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_params
      @order = Order.find(params[:id])
      @shippings = Shipping.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:total_price, :completed_date, 
                                    :shipping_id, 
                                    :address_attributes => [:address, :zipcode, :city, :phone, :country])
    end
end
