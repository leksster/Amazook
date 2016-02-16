class ShippingsController < ApplicationController
  before_action :set_services, only: [:index]
  before_action :authenticate_user!

  def index
  end

  private
  def set_services
    @order = Order.find(params[:order_id])
    @services = Shipping.all
  end
end
