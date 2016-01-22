class HomeController < ApplicationController
  def index
    @books = Book.all.order(id: :desc)
    @categories = Category.all
  end
end
