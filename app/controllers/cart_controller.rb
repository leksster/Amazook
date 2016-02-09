class CartController < ApplicationController
  before_action :cart_data, only: [:index, :checkout]
  before_action :create_order, only: :checkout

  def index
    # cart_data
  end

  def checkout
    respond_to do |format|
      if @order.save
        format.html { redirect_to edit_user_order_address_path(current_user, @order), notice: 'Your order in progress.' }
        session.delete(:cart)
        session[:order] = @order.id
      else
        format.html { render :index }
      end
    end
  end

  def add
    @book = Book.find(params[:book_id])
    session[:cart] ||= {}
    session[:cart][@book.id.to_s].nil? ? session[:cart][@book.id.to_s] = params[:qty].to_i : session[:cart][@book.id.to_s] += params[:qty].to_i
    redirect_to cart_url
  end

  def update
    session[:cart][params[:book_id]] = params[:qty].to_i
    redirect_to cart_url
  end

  def destroy
    session[:cart].delete(params[:id])
    if session[:cart].empty?
      session.destroy
    end
    redirect_to cart_url
  end

  def clear
    session.destroy
    redirect_to cart_url
  end

  private 
  def cart_data
    @subtotal = 0
    @empty = t('empty_cart')
    if !session[:cart].nil?
      @books = Book.find(session[:cart].keys)
      session[:cart].each do |k, v|
        @subtotal += Book.find(k).price * v
      end
    end
  end

  def create_order
    if user_signed_in?
      @order = current_user.orders.new(total_price: @subtotal, completed_date: Time.now) #???
      @books.each do |book|
        item = OrderItem.new(price: book.price, qty: session[:cart][book.id.to_s])
        item.book = book
        @order.order_items << item
      end
    else
      redirect_to new_user_session_path, alert: 'You must sign in.'
    end
  end

end
