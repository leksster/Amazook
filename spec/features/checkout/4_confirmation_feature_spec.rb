include Warden::Test::Helpers

feature 'Checkout Step 2: Delivery' do
  let(:order) { 
                create(:order, 
                       :user => user, 
                       :order_items => [create(:order_item)], 
                       :billing_address => create(:billing_address),
                       :shipping_address => create(:shipping_address),
                       :shipping => create(:shipping),
                       :credit_card => create(:credit_card))
              }
  let(:country) { create(:country) }
  let(:user) { create(:user) }

  background do
    allow(Country).to receive(:find).and_return(country)
    login_as(user)
    visit order_checkout_path(order, :confirm)
  end

  scenario 'it reaches Step 4 Confirmation' do
    expect(current_path).to include('confirm')
  end

  scenario 'user can go back and forth to any step now' do
    click_link('Address')
    expect(current_path).to include('billing')
    click_link('Delivery')
    expect(current_path).to include('delivery')
    click_link('Payment')
    expect(current_path).to include('payment')
    click_link('Confirm')
    expect(current_path).to include('confirm')
  end

  scenario 'user can procceed to the user\'s order when placed' do
    click_link('Place order')
    expect(page).to have_content('Your order is completed.')
  end
end