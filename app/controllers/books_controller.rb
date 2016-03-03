class BooksController < ApplicationController
  load_and_authorize_resource
  
  def index
    @books = Book.all.order(updated_at: :desc).page(params[:page]).per(50)
  end

  def show
    @book = Book.find(params[:id])
  end
end
