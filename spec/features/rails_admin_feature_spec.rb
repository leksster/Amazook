include Warden::Test::Helpers
feature "RailsAdmin" do
  let(:admin) { create(:admin) }

  background do
    login_as(admin)
    visit rails_admin_path
  end
  scenario "Admin can visit /admin path" do
    expect(current_path).to eq rails_admin_path
  end
  scenario "Admin can see orders' state and total price" do
    visit rails_admin.new_path(model_name: 'order')
    expect(current_path).to eq rails_admin.new_path(model_name: 'order')
    expect(page.find('.aasm_state_field')).to have_content 'Aasm state'
    expect(page.find('.total_price_field')).to have_content 'Total price'   
  end

  scenario "Admin can see ratings' state and marks" do
    visit rails_admin.new_path(model_name: 'rating')
    expect(current_path).to eq rails_admin.new_path(model_name: 'rating')
    expect(page.find('.aasm_state_field')).to have_content 'Aasm state'
    expect(page.find('.rating_field')).to have_content 'Rating'  
  end

  # scenario "Should be an errors when data is incorrect" do
  #   visit new_user_registration_path
  #   within '#new_user' do
  #     fill_in 'Email', with: 'sgsa@sag'
  #     fill_in 'Password', with: '12'
  #     fill_in 'Password confirmation', with: '12345'
  #     fill_in 'Firstname', with: ''
  #     fill_in 'Lastname', with: ''
  #     click_button('Sign up')
  #   end
  #   expect(page).to have_content 'Sign up'
  #   expect(page).to have_content 'errors'
  # end
end

