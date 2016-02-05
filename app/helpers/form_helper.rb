module FormHelper
  def setup_address(user)
    user.address.nil? ? user.build_address : user
    user
  end
  
  def setup_order(order)
    order.address.nil? ? order.build_address : order
    order
  end
end