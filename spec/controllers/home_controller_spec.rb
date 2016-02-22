RSpec.describe HomeController, type: :controller do

  let(:book) { create(:book) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assignes @books" do
      get :index
      expect(assigns(:books)).not_to be_nil
    end
  end
end
