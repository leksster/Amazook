feature "Cart" do
  let(:book1) { create(:book) }
  
  before :each do
    visit book_path(book1.id)
  end

  scenario "Visitors can see Add to cart button" do
    expect(page).to have_selector(:link_or_button, 'Add to cart')
  end

  scenario "Visitors can Add one book to cart" do
    find(:button, 'Add to cart').click
    expect(page.current_path).to eq(cart_path)
    expect(page).to have_content(book1.title)
  end

  scenario "Visitors can Add numerous books to cart" do
    fill_in "qty", with: '5'
    find(:button, 'Add to cart').click
    expect(page).to have_field('1', with: '5')
  end

  scenario "Visitors can Empty the cart" do
    find(:button, 'Add to cart').click
    find(:link, 'Empty cart').click
    expect(page.current_path).to eq(root_path)
  end

  scenario "Visitors can update quantity of the book in the cart" do
    fill_in "qty", with: '5'
    find(:button, 'Add to cart').click
    fill_in "1", with: '50'
    find(:button, 'Update').click
    expect(page).to have_field('1', with: '50')
  end

  scenario "Visitor can delete specific book from the cart" do
    find(:button, 'Add to cart').click
    visit book_path(book1)
    find(:button, 'Add to cart').click
    find(:link, 'X', href: "/cart?id=#{book1.id}").click
    expect(page).not_to have_content('Blah')
  end
  
end