class RatingsController < ApplicationController
  before_action :set_book

  def show
  end

  def new
    @rating = @book.ratings.new
  end

  def create
    @rating = @book.ratings.new(rating_params)

    if @rating.save
      redirect_to @book, notice: 'Todo item was successfully created.'
    else
      redirect_to new_book_rating_url, alert: 'Not saved'
    end
  end

  def edit
  end

  private
  def set_book
    @book = Book.find(params[:book_id])
  end

  def rating_params
    params.require(:rating).permit(:rating, :review_text)
  end
end
