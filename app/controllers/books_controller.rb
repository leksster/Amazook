class BooksController < ApplicationController
  def index
    @books = Book.all.order(:title).page(params[:page]).per(50)
  end

  def show
    @book = Book.find(params[:id])
  end
end
