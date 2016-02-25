RSpec.describe OrdersController, type: :controller do
  include Devise::TestHelpers
  let(:user)  { create(:user) }
  let(:order) { 
                create( :order, 
                  order_items: [create(:order_item), create(:order_item)], 
                  billing_address: create(:billing_address), 
                  shipping_address: create(:shipping_address), 
                  shipping: create(:shipping, :costs => 6), 
                  credit_card: create(:credit_card), 
                  user: user ) 
              }

  shared_examples "unathenticated user" do
    it "redirects to sign_in page" do
      sign_out user
      get action, params
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  before(:each) do 
    allow(Order).to receive(:find).and_return(order)
    allow(controller).to receive(:current_user).and_return(user)
    sign_in user
  end

  describe "GET #index" do
    let (:action) { :index }
    let (:params) { "" }

    it_behaves_like "unathenticated user"

    context "authenticated user" do
      it "returns http success" do
        get action
        expect(response).to have_http_status(:success)
      end
      it "assigns @orders" do
        get action
        expect(assigns(:orders)).to be_a(ActiveRecord::AssociationRelation)
      end
      it "assigns @in_progress" do
        get action
        expect(assigns(:in_progress)).to be_a(ActiveRecord::AssociationRelation)
      end
      it "assigns @in_queue" do
        get action
        expect(assigns(:in_queue)).to be_a(ActiveRecord::AssociationRelation)
      end
      it "assigns @delivered" do
        get action
        expect(assigns(:delivered)).to be_a(ActiveRecord::AssociationRelation)
      end
    end
  end

  describe "GET #show" do
    let (:action) { :show }
    let (:params) { {:id => order.id} }

    it_behaves_like "unathenticated user"

    context "authenticated user" do
      it "returns http success" do
        get action, :id => order.id
        expect(response).to have_http_status(:success)
      end
      it "assigns @order" do
        get action, :id => order.id
        expect(assigns(:order)).to be(order)
      end
    end
  end

  describe "PUT #update" do
    let (:action) { :update }
    let (:params) { {:id => order.id} }

    it_behaves_like "unathenticated user"

    context "authenticated user" do
      it "assigns @order" do
        put action, params
        expect(assigns(:order)).to be(order)
      end
      it "changes @order#total_price according to shipments cost" do
        expect{ put action, params }.to change(order, :total_price).by(order.shipping.costs)
      end
      it "changes current_user#billing_address if there's none" do
        expect { put action, params }.to change(user, :billing_address)
      end
      it "does not change current_user#billing_address if there's one" do
        user.billing_address = create(:billing_address)
        expect { put action, params }.not_to change(user, :billing_address)
      end
      it "changes current_user#shipping_address if there's none" do
        expect { put action, params }.to change(user, :shipping_address)
      end
      it "does not change current_user#shipping_address if there's one" do
        user.shipping_address = create(:shipping_address)
        expect { put action, params }.not_to change(user, :shipping_address)
      end
      it "changes order#completed_date" do
        expect { put action, params }.to change(order, :completed_date)
      end
      it "saves the order" do
        allow(order).to receive(:queued!).and_return(true)
        expect(order).to receive(:save).and_return(true)
        put action, params
      end
      it "redirects to order path" do
        put action, params
        expect(response).to redirect_to(order_path)
      end
    end
  end
end
