class CartController < ApplicationController

  def index
    @cart = t('empty_cart')
  end

end
