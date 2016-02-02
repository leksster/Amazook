class CartController < ApplicationController

  def index
    @subtotal = 0
    @empty = t('empty_cart')
    if session?
      @books = Book.find(session[:cart].keys) if session?
      session[:cart].each do |k, v|
        @subtotal += Book.find(k).price * v
      end
    end
  end

  def add
    @book = Book.find(params[:book_id])
    session[:cart] ||= {}
    session[:cart][@book.id.to_s].nil? ? session[:cart][@book.id.to_s] = 1 : session[:cart][@book.id.to_s] += 1
    redirect_to cart_url
  end

  def clear
    session[:cart].delete(params[:id])
    if session[:cart].empty?
      session.destroy
    end
    redirect_to cart_url
  end

  private
  def session?
    !session[:cart].nil?
  end

end
