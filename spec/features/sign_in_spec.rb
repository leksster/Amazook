feature "Sign In" do
  scenario "Registered user can successfully log in via sign in form" do
    user = create(:user)
    visit new_user_session_path
    within '#new_user' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button('Log in')
    end
    expect(page).to have_content 'Signed in successfully.'
  end
  
  scenario "Unregistered user can't successfully log in" do
    visit new_user_session_path
    within '#new_user' do
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Password', with: 'aabbbbs'
      click_button('Log in')
    end
    expect(page).to have_content 'Invalid email or password.'
  end
end