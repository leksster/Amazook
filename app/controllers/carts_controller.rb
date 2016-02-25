class CartsController < ApplicationController
  before_action :cart_data, except: :clear
  before_action :authenticate_user!, only: [:checkout]

  def show
  end

  def checkout
    respond_to do |format|
      @order = @cart.build_order_for(current_user)
      if @order.save && !@cart.session.empty?
        format.html { redirect_to order_checkout_index_path(@order), notice: 'In order to proceed, please provide additional details.' }
        session.delete(:cart)
      else
        format.html { redirect_to cart_path, alert: "Something went wrong" }
      end
    end
  end

  def add
    @cart.add_book(params[:book_id].to_s, params[:qty].to_i)
    redirect_to cart_url
  end

  def update
    @cart.update_books(params)
    render :show
  end

  def destroy
    @cart.remove_book(params[:id])
    render :show
  end

  def clear
    session.delete(:cart)
    redirect_to root_path
  end

  private 

  def cart_data
    @cart = Cart.new(session[:cart] ||= {})
  end
end
