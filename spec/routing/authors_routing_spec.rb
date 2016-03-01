RSpec.describe 'routes for Authors', type: :routing do
  it "routes to #show" do
    expect(get('/authors/1')).to route_to("authors#show", :id => "1")
  end

  it "routes to #index" do
    expect(get('/authors')).to route_to("authors#index")
  end
end