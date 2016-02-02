class CartController < ApplicationController

  def index
    @empty = t('empty_cart')
    @books = Book.find(session[:cart].keys) if session?
  end

  def add
    @book = Book.find(params[:book_id])
    session[:cart] ||= {}
    session[:cart][@book.id.to_s].nil? ? session[:cart][@book.id.to_s] = 1 : session[:cart][@book.id.to_s] += 1
    redirect_to @book
  end

  private
  def session?
    !session[:cart].nil?
  end

end
