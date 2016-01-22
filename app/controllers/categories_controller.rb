class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @categories = Category.all
  end

  def index
    @categories = Category.all
  end
end
