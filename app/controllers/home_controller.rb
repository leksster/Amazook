class HomeController < ApplicationController
  def index
    @books = Book.all.order(id: :desc).page(params[:page]).per(12)
    @categories = Category.all
  end
end
