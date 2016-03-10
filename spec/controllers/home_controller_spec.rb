require_relative '../support/shared_contexts.rb'

RSpec.describe HomeController, type: :controller do

  let(:book) { create(:book) }

  describe "GET #index" do
    before { get :index }

    it_behaves_like 'http success'

    it "assignes @books" do
      expect(assigns(:books)).not_to be_nil
    end
  end
end
