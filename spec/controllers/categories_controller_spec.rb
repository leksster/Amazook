RSpec.describe CategoriesController, type: :controller do

  let(:category) { create(:category) }

  describe "GET #show" do
    it "returns http success" do
      get :show, id: category.id
      expect(response).to have_http_status(:success)
    end
    it "assignes @category" do
      get :show, id: category.id
      expect(assigns(:category)).not_to be_nil
    end
  end
end
