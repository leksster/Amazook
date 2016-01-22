class BooksController < ApplicationController
  def show
    @categories = Category.all
    @book = Book.find(params[:id])
  end
end
