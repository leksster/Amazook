RSpec.describe 'routes for Checkout', type: :routing do
  it "routes to #index" do
    expect(get('/orders/1/checkout')).to route_to("checkout#index", :order_id => '1')
  end

  it "routes to #show required step" do
    expect(get('/orders/1/checkout/billing')).to route_to("checkout#show", :order_id => '1', :id => 'billing')
    expect(get('/orders/1/checkout/shipping')).to route_to("checkout#show", :order_id => '1', :id => 'shipping')
    expect(get('/orders/1/checkout/delivery')).to route_to("checkout#show", :order_id => '1', :id => 'delivery')
    expect(get('/orders/1/checkout/payment')).to route_to("checkout#show", :order_id => '1', :id => 'payment')
    expect(get('/orders/1/checkout/confirm')).to route_to("checkout#show", :order_id => '1', :id => 'confirm')
  end

  it "routes to #update required step" do
    expect(patch('/orders/1/checkout/billing')).to route_to("checkout#update", :order_id => '1', :id => 'billing')
    expect(patch('/orders/1/checkout/shipping')).to route_to("checkout#update", :order_id => '1', :id => 'shipping')
    expect(patch('/orders/1/checkout/delivery')).to route_to("checkout#update", :order_id => '1', :id => 'delivery')
    expect(patch('/orders/1/checkout/payment')).to route_to("checkout#update", :order_id => '1', :id => 'payment')
    expect(patch('/orders/1/checkout/confirm')).to route_to("checkout#update", :order_id => '1', :id => 'confirm')

    expect(put('/orders/1/checkout/billing')).to route_to("checkout#update", :order_id => '1', :id => 'billing')
    expect(put('/orders/1/checkout/shipping')).to route_to("checkout#update", :order_id => '1', :id => 'shipping')
    expect(put('/orders/1/checkout/delivery')).to route_to("checkout#update", :order_id => '1', :id => 'delivery')
    expect(put('/orders/1/checkout/payment')).to route_to("checkout#update", :order_id => '1', :id => 'payment')
    expect(put('/orders/1/checkout/confirm')).to route_to("checkout#update", :order_id => '1', :id => 'confirm')
  end
end