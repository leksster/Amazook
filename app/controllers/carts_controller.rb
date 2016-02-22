class CartsController < ApplicationController
  before_action :cart_data
  before_action :authenticate_user!, only: [:checkout]
  def show
  end

  def checkout
    respond_to do |format|
      create_order
      if @order.save
        format.html { redirect_to order_checkout_index_path(@order), notice: 'In order to proceed, please provide additional details.' }
        session.delete(:cart)
      else
        format.html { redirect_to cart_path, alert: "Something went wrong" }
      end
    end
  end

  def add
    @cart.add(params[:book_id].to_s, params[:qty].to_i) unless params[:qty].empty?
    redirect_to cart_url
  end

  def update
    @cart.update(params)
    render :show
  end

  def destroy
    session[:cart].delete(params[:id])
    redirect_to cart_url
  end

  def clear
    session.delete(:cart)
    redirect_to cart_url
  end

  private 
  def cart_data
    @cart = Cart.new(session[:cart] ||= {})
  end

  def create_order
    @order = current_user.orders.new(total_price: @cart.subtotal, completed_date: Time.now) #???
    @order.order_items << @cart.order_items
  end

end