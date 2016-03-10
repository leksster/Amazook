RSpec.describe Cart, type: :model do
  let(:book1) { create(:book) }
  let(:book2) { create(:book) }
  let(:cart) { Cart.new(book1.id => 5, book2.id => 2) }

  it "#subtotal" do
    expect(cart.subtotal).to eq(book1.price * 5 + book2.price * 2)
  end

  it "#books" do
    expect(cart.books).to eq([book1, book2])
  end

  it "#order_items" do
    expect(cart.order_items).to be_a(Array)
    expect(cart.order_items).to include(a_kind_of(OrderItem))
  end

  it "#build_order_for(user)" do
    user = create(:user)
    expect(cart.build_order_for(user)).to be_a(Order)
    expect(cart.build_order_for(user).user).to eq(user)
  end

  it '#add_book' do
    expect { cart.add_book(12, 2) }.to change { cart.session }
  end

  it '#remove_book' do 
    expect { cart.remove_book(book1.id) }.to change {cart.session}.from({book1.id=>5, book2.id=>2}).to({book2.id=>2})
  end

  it '#update_books' do
    params = {book1.id => 2, book2.id => 1}
    expect { cart.update_books(params) }.to change{cart.session}.from({book1.id=>5, book2.id=>2}).to({book1.id=>2, book2.id=>1})
  end

  it '#discount' do
    coupon = create(:coupon)
    expect(cart.discount(coupon.code)).to eq(cart.subtotal*coupon.discount/100.0)
  end
end