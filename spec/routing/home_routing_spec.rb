RSpec.describe 'routes for Home', type: :routing do
  it "routes to #index" do
    expect(get('/')).to route_to("home#index")
  end
end