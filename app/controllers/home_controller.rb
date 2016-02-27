class HomeController < ApplicationController
  def index
    @books = Book.all.order(updated_at: :desc).page(params[:page]).per(12)
  end
end
