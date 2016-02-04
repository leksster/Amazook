module FormHelper
  def setup_order(order)
    order.address.nil? ? order.build_address : order
    order
  end
end