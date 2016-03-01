RSpec.describe 'routes for Users', type: :routing do
  it "routes to devise/sessions#new" do
    expect(get('/users/sign_in')).to route_to("devise/sessions#new")
  end

  it "routes to devise/session#create" do
    expect(post('/users/sign_in')).to route_to("devise/sessions#create")
  end

  it "routes to devise/session#destroy" do
    expect(delete('/users/sign_out')).to route_to("devise/sessions#destroy")
  end

  it "routes to omniauth_callbacks#passthru" do
    expect(post('/users/auth/facebook')).to route_to("omniauth_callbacks#passthru", :provider => 'facebook')
    expect(get('/users/auth/facebook')).to route_to("omniauth_callbacks#passthru", :provider => 'facebook')
  end

  it "routes to devise/passwords#create" do
    expect(post('/users/password')).to route_to("devise/passwords#create")
  end

  it "routes to devise/passwords#new" do
    expect(get('/users/password/new')).to route_to("devise/passwords#new")
  end

  it "routes to devise/passwords#edit" do
    expect(get('/users/password/edit')).to route_to("devise/passwords#edit")
  end

  it "routes to devise/passwords#update" do
    expect(patch('/users/password')).to route_to("devise/passwords#update")
    expect(put('/users/password')).to route_to("devise/passwords#update")
  end

  it "routes to registrations#cancel" do
    expect(get('/users/cancel')).to route_to("registrations#cancel")
  end

  it "routes to registrations#create" do
    expect(post('/users')).to route_to("registrations#create")
  end

  it "routes to registrations#new" do
    expect(get('/users/sign_up')).to route_to("registrations#new")
  end

  it "routes to registrations#edit" do
    expect(get('/users/edit')).to route_to("registrations#edit")
  end

  it "routes to registrations#update" do
    expect(patch('/users')).to route_to("registrations#update")
    expect(put('/users')).to route_to("registrations#update")
  end

  it "routes to registrations#destroy" do
    expect(delete('/users')).to route_to("registrations#destroy")
  end

  it "routes to registrations#update_info" do
    expect(put('/user')).to route_to("registrations#update_info")
  end

  it "routes to registrations#update_password" do
    expect(put('/user/update_password')).to route_to("registrations#update_password")
  end
end