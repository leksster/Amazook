feature "Home page" do
  scenario "Visitor should see navigation, sidebar, slider, book's thumbnails, pagination on home page" do
    60.times { create(:book) }
    5.times { create(:category) }
    visit root_path
    expect(page).to have_css "div.navbar-header"
    expect(page).to have_css "div.list-group"
    expect(page).to have_css "div.carousel.slide"
    expect(page).to have_css 'div.thumbnail'
    expect(page).to have_css 'ul.pagination'
  end
end

