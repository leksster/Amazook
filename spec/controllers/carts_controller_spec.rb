RSpec.describe CartsController, type: :controller do
  include Devise::TestHelpers

  let(:cart) { Cart.new() }
  let(:book) { create(:book) }
  before do 
    allow(controller).to receive(:params).and_return(:qty => '5', :book_id => book.id) 
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
    it "assignes @cart" do
      get :show
      expect(assigns(:cart)).not_to be_nil
    end    
  end

  describe "POST #add" do
    it "assignes @cart" do
      post :add, :book_id => book.id
      expect(assigns(:cart)).not_to be_nil
    end
    it "should redirect_to cart when book was added" do
      post :add, :book_id => book.id
      expect(response).to redirect_to(cart_path)
    end
    it "calls #add_book on @cart" do    
      expect_any_instance_of(Cart).to receive(:add_book).with(book.id.to_s, controller.params[:qty].to_i)
      delete :add, :book_id => book.id
    end
  end

  describe "POST #update" do
    it "assignes @cart" do
      patch :update
      expect(assigns(:cart)).not_to be_nil
    end
    it "calls #update_books on @cart" do    
      expect_any_instance_of(Cart).to receive(:update_books)
      patch :update
    end
    it "renders :show" do
      patch :update
      expect(response).to render_template :show
    end
  end

  describe "DELETE #destroy" do
    it "assignes @cart" do
      delete :destroy
      expect(assigns(:cart)).not_to be_nil
    end
    it "calls #remove_book on @cart" do    
      expect_any_instance_of(Cart).to receive(:remove_book)
      delete :destroy
    end
    it "renders :show" do
      delete :destroy
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
    it "assignes @cart" do
      post :checkout
      expect(assigns(:cart)).not_to be_nil
    end

    it "assignes @order" do
      sign_in create(:user)
      post :checkout
      expect(assigns(:order)).not_to be_nil
    end

    it "allows to checkout registered user " do
      sign_in create(:user)
      post :checkout
      expect(flash[:notice]).to eq 'In order to proceed, please provide additional details.'
    end

    it "not allows to checkout unregistered user" do
      post :checkout
      expect(response).to redirect_to(new_user_session_path)
    end
  end

end
