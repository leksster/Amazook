feature "Registered checkout" do

  before :each do
    user = create(:user)
    create(:book, :id => 1, :title => 'Blah')
    create(:book, :id => 2, :title => 'Book')
    visit new_user_session_path
    within '#new_user' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button('Log in')
    end
    visit book_path(1)
  end

  scenario "Registered user can successfully checkout with cart items" do 
    find(:button, 'Add to cart').click
    find(:link, 'Checkout').click
    expect(page).to have_content('In order to proceed, please provide additional details.')
  end  

end

feature "Unregistered checkout" do

  before :each do
    create(:book, :id => 1, :title => 'Blah')
    create(:book, :id => 2, :title => 'Book')
    visit book_path(1)
  end

  scenario "Unregistered user can't checkout" do 
    find(:button, 'Add to cart').click
    find(:link, 'Checkout').click
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end  

end