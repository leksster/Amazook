RSpec.describe CartsController, type: :controller do
  include Devise::TestHelpers

  let(:cart) { Cart.new(:session) }
  let(:book) { create(:book) }
  let(:order) { create(:order) }
  let(:user) { create(:user) }

  before do 
    allow(controller).to receive(:params).and_return(:qty => '5', :book_id => book.id) 
  end

  describe "GET #show" do
    before { get :show }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "assignes @cart" do
      expect(assigns(:cart)).not_to be_nil
    end    
  end

  describe "POST #add" do
    before do
      allow(Cart).to receive(:new).and_return(cart)
      allow(cart).to receive(:add_book).and_return(true)
      post :add, :book_id => book.id
    end    
    it "assignes @cart" do
      expect(cart).not_to be_nil
    end
    it "should redirect_to cart when book was added" do
      expect(response).to redirect_to(cart_path)
    end
    it "calls #add_book on @cart" do    
      expect(cart).to receive(:add_book).with(book.id.to_s, controller.params[:qty].to_i)
      post :add, :book_id => book.id
    end
  end

  describe "POST #update" do
    before do
      allow(Cart).to receive(:new).and_return(cart)
      allow(cart).to receive(:update_books).and_return(order)
      patch :update
    end   
    it "assignes @cart" do
      expect(assigns(:cart)).not_to be_nil
    end
    it "calls #update_books on @cart" do    
      expect(cart).to receive(:update_books)
      patch :update
    end
    it "renders :show" do
      expect(response).to render_template :show
    end
  end

  describe "DELETE #destroy" do
    before do
      allow(Cart).to receive(:new).and_return(cart)
      allow(cart).to receive(:remove_book).and_return(true)
      delete :destroy
    end   
    it "assignes @cart" do
      expect(assigns(:cart)).not_to be_nil
    end
    it "calls #remove_book on @cart" do    
      expect(cart).to receive(:remove_book)
      delete :destroy
    end
    it "renders :show" do
      expect(response).to render_template :show
    end
  end

  describe "POST #clear" do
    it "calls #delete(:cart) on session" do    
      expect(controller.session).to receive(:delete).with(:cart)
      post :clear
    end
    it "redirects to main page" do
      post :clear
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST #checkout" do
    before do
      allow(Cart).to receive(:new).and_return(cart)
      allow(cart).to receive(:build_order_for).and_return(order)
      sign_in user
      post :checkout
    end

    it "assignes @cart" do
      expect(assigns(:cart)).not_to be_nil
    end

    it "calls #build_order_for on cart" do
      expect(cart).to receive(:build_order_for)
      post :checkout
    end

    it "calls #save on order" do
      expect(order).to receive(:save)
      post :checkout
    end

    it "clears the cart session" do
      expect(controller.session).to receive(:delete).with(:cart)
      post :checkout
    end

    it 'redirects to checkout controller' do
      expect(response).to redirect_to(order_checkout_index_path(order))
    end

    it "assignes @order" do
      expect(assigns(:order)).not_to be_nil
    end

    it "allows to checkout registered user " do
      expect(flash[:notice]).to eq 'In order to proceed, please provide additional details.'
    end

    it "not allows to checkout unregistered user" do
      sign_out user
      post :checkout
      expect(response).to redirect_to(new_user_session_path)
    end
  end

end
