RSpec.describe 'routes for Carts', type: :routing do
  it "routes to #show" do
    expect(get('/cart')).to route_to("carts#show")
  end

  it "routes to #destroy" do
    expect(delete('/cart')).to route_to("carts#destroy")
  end

  it "routes to #update" do
    expect(put('/cart')).to route_to("carts#update")
    expect(patch('/cart')).to route_to("carts#update")
  end

  it "routes to #clear" do
    expect(post('/cart/clear')).to route_to("carts#clear")
  end

  it "routes to #checkout" do
    expect(post('/cart/checkout')).to route_to("carts#checkout")
  end

  it "routes to #add" do
    expect(post('cart/1')).to route_to("carts#add", :book_id => '1')
  end
end