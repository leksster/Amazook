feature "Registration" do
  scenario "Visitor registers successfully via register form" do
    visit new_user_registration_path
    within '#new_user' do
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Password', with: '12345'
      fill_in 'Password confirmation', with: '12345'
      fill_in 'Firstname', with: Faker::Name.first_name
      fill_in 'Lastname', with: Faker::Name.last_name
      click_button('Sign up')
    end
    expect(page).not_to have_content 'Sign up'
    expect(page).to have_content 'Log out'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario "Should be an errors when data is incorrect" do
    visit new_user_registration_path
    within '#new_user' do
      fill_in 'Email', with: 'sgsa@sag'
      fill_in 'Password', with: '12'
      fill_in 'Password confirmation', with: '12345'
      fill_in 'Firstname', with: ''
      fill_in 'Lastname', with: ''
      click_button('Sign up')
    end
    expect(page).to have_content 'Sign up'
    expect(page).to have_content 'errors'
  end
end

