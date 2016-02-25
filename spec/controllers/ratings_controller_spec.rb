RSpec.describe RatingsController, type: :controller do
  include Devise::TestHelpers
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:rating) { create(:rating) }

  describe "GET #new" do
    context "authenticated user" do
      before do
        sign_in user
      end
      it "returns http success" do
        get :new, :book_id => book.id
        expect(response).to have_http_status(:success)
      end
      it "assigns @rating" do
        get :new, :book_id => book.id
        expect(assigns(:rating)).not_to be_nil
      end
      it "assigns @book" do
        get :new, :book_id => book.id
        expect(assigns(:book)).to eq(book)
      end
    end
    context "unauthenticated user" do
      it "redirects to sign_in page" do
        get :new, :book_id => book.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST #create" do
    context "authenticated user" do
      before do
        allow(controller).to receive(:current_user).and_return(user)
        sign_in user
      end
      it "redirects to book when created" do
        post :create, :book_id => book.id, :rating => rating.attributes
        expect(response).to redirect_to(book)
      end
    end
    context "unauthenticated user" do
      it "redirects to sign_in page" do
        post :create, :book_id => book.id, :rating => rating.attributes
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
