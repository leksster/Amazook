class RatingsController < ApplicationController
  before_action :set_book

  def new
    if user_signed_in?
      @rating = @book.ratings.new
    else
      redirect_to new_user_session_path, alert: 'You must sign in.'
    end
  end

  def create
    @rating = @book.ratings.new(rating_params)
    @rating.user = current_user

    if not_reviewed? && @rating.save
      redirect_to @book, notice: 'Pending.'
    else
      redirect_to new_book_rating_url, alert: 'Not saved'
    end
  end

  private

  def not_reviewed?
    @book.ratings.where(:user => current_user).empty?
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  def rating_params
    params.require(:rating).permit(:rating, :review_text)
  end
end
