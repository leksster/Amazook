class AuthorsController < ApplicationController
  def index
    @authors = Author.all.order(:lastname).page(params[:page]).per(50)
  end

  def show
    @author = Author.find(params[:id])
  end
end
