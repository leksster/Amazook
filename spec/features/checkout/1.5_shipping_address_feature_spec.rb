include Warden::Test::Helpers

feature 'Checkout Step 1.5: Shipping address' do
  let(:order) do
    create(:order, 
           :user            => user, 
           :order_items     => [create(:order_item)], 
           :billing_address => create(:billing_address)) 
  end 

  let(:country) { create(:country) }
  let(:shipping_address) { create(:shipping_address) }
  let(:user) { create(:user) }

  background do
    login_as(user)
    country
    visit order_checkout_path(order, :shipping)
  end

  scenario 'it reaches Step 1.5 Shipping address.' do
    expect(current_path).to include('shipping')
    expect(page).not_to have_content('Use billing address')
  end

  scenario 'user can return to previous :billing step' do
    click_link('Back')
    expect(current_path).to include('billing')
  end

  scenario 'user can\'t jump to next steps without filled data' do
    click_link('Delivery')
    click_link('Payment')
    click_link('Confirm')
    expect(current_path).to include('shipping')
  end
  scenario 'user can procceed to the :delivery step with valid params' do
    fill_in 'order_shipping_address_attributes_firstname', with: shipping_address.firstname
    fill_in 'order_shipping_address_attributes_lastname', with: shipping_address.lastname
    fill_in 'order_shipping_address_attributes_address', with: shipping_address.address
    fill_in 'order_shipping_address_attributes_zipcode', with: shipping_address.zipcode
    fill_in 'order_shipping_address_attributes_city', with: shipping_address.city
    fill_in 'order_shipping_address_attributes_phone', with: shipping_address.phone
    select country.name, from: 'order[shipping_address_attributes][country]'
    click_button 'Continue'
  end
end