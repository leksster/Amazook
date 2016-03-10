RSpec.describe BooksController, type: :controller do
  include Devise::TestHelpers
  
  let(:book) { create(:book) }

  describe "GET #index" do
    before { get :index }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders index view" do
      expect(response).to render_template(:index)
    end

    it "assignes @books" do
      expect(assigns(:books)).not_to be_nil
    end
  end

  describe "GET #show" do
    before { get :show, id: book.id }

    it "renders index view" do
      expect(response).to render_template(:show)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "assignes @book" do
      expect(assigns(:book)).not_to be_nil
    end
  end

end
