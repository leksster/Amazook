RSpec.describe 'routes for Books', type: :routing do
  it "routes to #show" do
    expect(get('/books/1')).to route_to("books#show", :id => "1")
  end

  it "routes to #index" do
    expect(get('/books')).to route_to("books#index")
  end
end