include Warden::Test::Helpers

feature 'Checkout Step 2: Delivery' do
  let(:order) { 
                create(:order, 
                       :user => user, 
                       :order_items => [create(:order_item)], 
                       :billing_address => create(:billing_address),
                       :shipping_address => create(:shipping_address),
                       :shipping => create(:shipping))
              }
  let(:country) { create(:country) }
  let(:user) { create(:user) }
  let(:credit_card) { create(:credit_card) }

  background do
    allow(Country).to receive(:find).and_return(country)
    login_as(user)
    visit order_checkout_path(order, :payment)
  end

  scenario 'it reaches Step 3 Payment' do
    expect(current_path).to include('payment')
  end

  scenario 'user can return to previous :delivery step' do
    click_link('Back')
    expect(current_path).to include('delivery')
  end

  scenario 'user can return to previous :billing step' do
    click_link('Address')
    expect(current_path).to include('billing')
  end

  scenario 'user can\'t jump to :confirm step' do
    click_link('Confirm')
    expect(current_path).to include('payment')
  end

  scenario 'user can procceed to the :confirm step with valid params' do
    fill_in 'Number', with: credit_card.number
    select '05', from: 'order_credit_card_attributes_expiration_month'
    select '2020', from: 'order_credit_card_attributes_expiration_year'
    fill_in 'Cvv', with: credit_card.cvv
    fill_in 'Firstname', with: credit_card.firstname
    fill_in 'Lastname', with: credit_card.lastname
    click_button('Continue')
    expect(current_path).to include('confirm')
  end
end