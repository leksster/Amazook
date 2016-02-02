class BooksController < ApplicationController
  def index
    @books = Book.all.order(:title).page(params[:page]).per(50)
  end

  def show
    @categories = Category.all
    @book = Book.find(params[:id])
  end

  def buy
    @book = Book.find(params[:id])
    session[:cart] = @book.id
  end
end
