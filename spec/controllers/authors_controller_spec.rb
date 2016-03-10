require_relative '../support/shared_contexts.rb'

RSpec.describe AuthorsController, type: :controller do

  let(:author) { create(:author) }


  describe "GET #index" do
    before { get :index }

    it_behaves_like 'http success'

    it "renders index template" do
      expect(response).to render_template(:index)
    end

    it "assignes @authors" do
      expect(assigns(:authors)).not_to be_nil
    end
  end

  describe "GET #show" do
    before { get :show, id: author.id }

    it "renders show template" do
      expect(response).to render_template(:show)
    end

    it "assignes @author" do
      expect(assigns(:author)).not_to be_nil
    end
  end
end
