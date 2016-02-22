RSpec.describe AuthorsController, type: :controller do

  let(:author) { create(:author) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assignes @authors" do
      get :index
      expect(assigns(:authors)).not_to be_nil
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: author.id
      expect(response).to have_http_status(:success)
    end
    it "assignes @author" do
      get :show, id: author.id
      expect(assigns(:author)).not_to be_nil
    end
  end
end
