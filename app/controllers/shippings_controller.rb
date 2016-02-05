class ShippingsController < ApplicationController
  before_action :set_services, only: [:index]

  def index
  end

  private
  def set_services
    @order = Order.find(session[:order])
    @services = Shipping.all
  end
end
