class RatingsController < ApplicationController
  before_action :set_book
  before_action :authenticate_user!
  load_and_authorize_resource

  def new
    @rating = @book.ratings.new
  end

  def create
    @rating = @book.ratings.new(rating_params)
    @rating.user = current_user
    if @book.not_reviewed_by?(current_user) 
      if @rating.save(rating_params)
        redirect_to @book, notice: 'Thank you.'
      else
        render :new
      end
    else
      redirect_to new_book_rating_url, alert: 'Already reviewed.'
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def rating_params
    params.require(:rating).permit(:rating, :review_text)
  end
end
