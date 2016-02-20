feature "Cart" do

  before :each do
    create(:book, :id => 1, :title => 'Blah')
    create(:book, :id => 2, :title => 'Book')
    visit book_path(1)
  end

  scenario "Visitors can see Add to cart button" do
    expect(page).to have_selector(:link_or_button, 'Add to cart')
  end

  scenario "Visitors can Add one book to cart" do
    find(:button, 'Add to cart').click
    expect(page.current_path).to eq(cart_path)
    expect(page).to have_content('Blah')
  end

  scenario "Visitors can Add numerous books to cart" do
    fill_in "qty", with: '5'
    find(:button, 'Add to cart').click
    expect(page).to have_field('1', with: '5')
  end

  scenario "Visitors can Empty the cart" do
    find(:button, 'Add to cart').click
    find(:link, 'Empty cart').click
    expect(page).to have_content('empty')
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
    visit book_path(2)
    find(:button, 'Add to cart').click
    find(:link, 'X', href: '/cart?id=1').click
    expect(page).not_to have_content('Blah')
  end
  
end