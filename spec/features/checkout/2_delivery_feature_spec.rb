include Warden::Test::Helpers

feature 'Checkout Step 2: Delivery' do
  let(:order) do
    create(:order, 
       :user             => user, 
       :order_items      => [create(:order_item)], 
       :billing_address  => create(:billing_address),
       :shipping_address => create(:shipping_address))
  end

  let(:country) { create(:country) }
  let(:user) { create(:user) }
  let(:shipping) { create(:shipping) }

  background do
    allow(Country).to receive(:find).and_return(country)
    allow(Shipping).to receive(:first).and_return(shipping)
    login_as(user)
    visit order_checkout_path(order, :delivery)
  end

  scenario 'it reaches Step 2 Delivery' do
    expect(current_path).to include('delivery')
    expect(page).not_to have_content('Use billing address')
    expect(page).to have_content('Delivery services')
  end

  scenario 'user can return to previous :shipping step' do
    click_link('Back')
    expect(current_path).to include('shipping')
  end

  scenario 'user can return to previous :billing step' do
    click_link('Address')
    expect(current_path).to include('billing')
  end

  scenario 'user can\'t jump to :payment & :confirm steps' do
    click_link('Payment')
    click_link('Confirm')
    expect(current_path).to include('delivery')
  end

  scenario 'user can procceed to the :payment step with valid params' do
    choose "order_shipping_id_#{Shipping.first.id}"
    click_button('Continue')
    expect(current_path).to include('payment')
  end
end