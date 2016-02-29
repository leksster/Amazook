feature "Registered user can checkout" do
  let(:user) { create(:user, firstname: 'Alex', lastname: 'Smith') }
  let(:billing_address) { create(:billing_address) }
  let(:shipping_address) { create(:shipping_address) }
  let(:credit_card) { create(:credit_card) }
  
  
  before :each do
    3.times { create(:shipping) }
    create(:country, name: 'Ukraine') 
    create(:book, :id => 1, :title => 'Blah')
    create(:book, :id => 2, :title => 'Book')
    visit new_user_session_path
    within '#new_user' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button('Log in')
    end
    visit book_path(1)
    find(:button, 'Add to cart').click
    find(:link, 'Checkout').click
  end

  scenario "Step 0: Registered user can successfully checkout with cart items" do 
    expect(page).to have_content('In order to proceed, please provide additional details.')
  end

  feature 'Step 1: Billing Address, it fills in billing address credentials' do
    background do
      fill_in 'Address', with: billing_address.address
      fill_in 'Zipcode', with: billing_address.zipcode
      fill_in 'City', with: billing_address.city
      fill_in 'Phone', with: billing_address.phone
      select 'Ukraine', from: 'order[billing_address_attributes][country]'
    end

    scenario 'it is on Step 1: Billing Address' do
      expect(URI.parse(current_url).to_s).to include('billing')
      expect(page).to have_content('Billing Address')
      expect(page).to have_content('Firstname')
      expect(page).to have_content('Lastname')
      expect(page).to have_content('Address')
      expect(page).to have_content('Zipcode')
      expect(page).to have_content('City')
      expect(page).to have_content('Phone')
      expect(page).to have_content('Country')
      expect(page).to have_content('Use billing address')
    end
    scenario 'user\'s firstname and lastname filled' do
      expect(page).to have_selector("input[value=#{user.firstname}]")
      expect(page).to have_selector("input[value=#{user.firstname}]")
    end

    feature 'Step 1.5 Shipping address. It unchecks Use billing address checkbox, continues' do
      background do
        uncheck 'shipping_use_billing_address'
        click_button('Save and continue')
      end
      scenario 'it reaches Step 1.5 Shipping address.' do
        expect(URI.parse(current_url).to_s).to include('shipping')
        expect(page).not_to have_content('Use billing address')
        expect(page).to have_content('Shipping Address')
      end
      scenario 'user can return to previous :billing step' do
        click_link('Back')
        expect(expect(URI.parse(current_url).to_s).to include('billing'))
      end

      feature 'Step 2 Delivery. It fills shipping address, continues' do
        background do
          fill_in 'order_shipping_address_attributes_firstname', with: shipping_address.firstname
          fill_in 'order_shipping_address_attributes_lastname', with: shipping_address.lastname
          fill_in 'order_shipping_address_attributes_address', with: shipping_address.address
          fill_in 'order_shipping_address_attributes_zipcode', with: shipping_address.zipcode
          fill_in 'order_shipping_address_attributes_city', with: shipping_address.city
          fill_in 'order_shipping_address_attributes_phone', with: shipping_address.phone
          select 'Ukraine', from: 'order[shipping_address_attributes][country]'
          click_button 'Continue'
        end
        scenario 'it reaches Step 2 Delivery' do
          expect(URI.parse(current_url).to_s).to include('delivery')
          expect(page).not_to have_content('Use billing address')
          expect(page).to have_content('Delivery services')
        end
        scenario 'user can return to previous :shipping step' do
          click_link('Back')
          expect(expect(URI.parse(current_url).to_s).to include('shipping'))
        end
      end
    end
    feature 'Step 2 Delivery. It checks Use billing address checkbox, continues' do
      background do
        check 'shipping_use_billing_address'
        click_button('Save and continue')
      end
      scenario 'it reaches Step 2 Delivery' do
        expect(URI.parse(current_url).to_s).to include('delivery')
        expect(page).not_to have_content('Use billing address')
        expect(page).to have_content('Delivery services')
      end
      scenario 'user can return to previous :shipping step' do
        click_link('Back')
        expect(expect(URI.parse(current_url).to_s).to include('shipping'))
      end
      feature 'Step 3 Payment. It chooses delivery service, continues' do
        background do
          choose "order_shipping_id_#{Shipping.first.id}"
          click_button('Continue')
        end
        scenario 'it reaches Step 3 Payment' do
          expect(URI.parse(current_url).to_s).to include('payment')
        end
        scenario 'user can return to previous :delivery step' do
          click_link('Back')
          expect(expect(URI.parse(current_url).to_s).to include('delivery'))
        end
        feature 'Step 4 Confirm. It fills credit_card info, continues' do
          background do
            fill_in 'Number', with: credit_card.number
            select '05', from: 'order_credit_card_attributes_expiration_month'
            select '2020', from: 'order_credit_card_attributes_expiration_year'
            fill_in 'Cvv', with: credit_card.cvv
            fill_in 'Firstname', with: credit_card.firstname
            fill_in 'Lastname', with: credit_card.lastname
            click_button('Continue')
          end
          scenario 'it reaches Step 4 Confirm' do
            expect(URI.parse(current_url).to_s).to include('confirm')
          end
          scenario 'user can go back and forth to any step now' do
            click_link('Address')
            expect(expect(URI.parse(current_url).to_s).to include('billing'))
            click_link('Delivery')
            expect(expect(URI.parse(current_url).to_s).to include('delivery'))
            click_link('Payment')
            expect(expect(URI.parse(current_url).to_s).to include('payment'))
            click_link('Confirm')
            expect(expect(URI.parse(current_url).to_s).to include('confirm'))
          end
          feature 'it clicks Place Order, redirects to user\'s order' do
            background do
              click_link('Place order')
            end
            scenario 'it redirects to user\'s order' do
              expect(page).to have_content('Your order is completed.')
            end
          end
        end
      end
    end
  end
end

feature "Unregistered user can't checkout" do

  before :each do
    create(:book, :id => 1, :title => 'Blah')
    create(:book, :id => 2, :title => 'Book')
    visit book_path(1)
  end

  scenario "redirects user to sign in page" do 
    find(:button, 'Add to cart').click
    find(:link, 'Checkout').click
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end  

end