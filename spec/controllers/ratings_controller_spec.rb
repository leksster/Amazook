require_relative '../support/shared_contexts.rb'

RSpec.describe RatingsController, type: :controller do
  include Devise::TestHelpers
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:rating) { create(:rating) }

  describe "GET #new" do
    context "authenticated user" do
      before do
        sign_in user
        get :new, :book_id => book.id
      end

      it_behaves_like "http success"

      it "assigns @rating" do
        expect(assigns(:rating)).not_to be_nil
      end
      it "assigns @book" do
        expect(assigns(:book)).to eq(book)
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
      it "renders :new if not valid" do
        post :create, :book_id => create(:book).id, :rating => attributes_for(:rating, review_text: nil)
        # byebug
        expect(response).to render_template :new
      end
      it "not allows to review > 1 time" do
        2.times { post :create, :book_id => book.id, :rating => rating.attributes }
        expect(response).to redirect_to(new_book_rating_url)
        expect(controller).to set_flash[:alert].to("Already reviewed.")
      end
    end
  end
end
