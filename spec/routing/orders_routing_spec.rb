RSpec.describe 'routes for Orders', type: :routing do
  it "routes to #index" do
    expect(get('/orders')).to route_to("orders#index")
  end
  it "routes to #show" do
    expect(get('/orders/1')).to route_to("orders#show", :id => '1')
  end
  it "routes to #update" do
    expect(put('/orders/1')).to route_to("orders#update", :id => '1')
    expect(patch('/orders/1')).to route_to("orders#update", :id => '1')
  end
end