RSpec.describe CheckoutController, type: :controller do
  include Devise::TestHelpers

  let(:user) { create(:user) }
  let(:order) { 
                create( :order, 
                  order_items: [create(:order_item)], 
                  billing_address: billing_address, 
                  shipping_address: shipping_address, 
                  shipping: create(:shipping), 
                  credit_card: create(:credit_card), 
                  user: user ) 
              }
  let(:shipping_address) { create(:shipping_address) }
  let(:billing_address) { create(:billing_address) }
  let(:credit_card) { create(:credit_card) }
  let(:order_in_queue) { create(:order, :aasm_state => 'in_queue') }

  describe "GET #show" do

    before(:each) do 
      allow(Order).to receive(:find).and_return(order)
      sign_in user
    end

    shared_examples "receives build_or_find methods" do
      it "#build_or_find_billing_address" do
        expect(order).to receive(:build_or_find_billing_address).with(user)
        get(:show, step_params)
      end

      it "#build_or_find_shipping_address" do
        expect(order).to receive(:build_or_find_shipping_address).with(user)
        get(:show, step_params)
      end

      it "#build_or_find_credit_card" do
        expect(order).to receive(:build_or_find_credit_card).with(user)
        get(:show, step_params)
      end

      it "assignes @order" do
        get :show, step_params
        expect(assigns(:order)).to be_a(Order)
      end
    end

    shared_examples "unathenticated users can't checkout" do
      it "redirects to log_in" do
        sign_out user
        get(:show, step_params)
        expect(response).to redirect_to(user_session_path)
      end
    end

    shared_examples "orders not .in_progress can't be edited" do
      it "redirects to order when not .in_progress?" do
        allow(Order).to receive(:find).and_return(order_in_queue)
        get(:show, { :order_id => order_in_queue.id, :id => :billing })
        expect(response).to redirect_to(order_path(order_in_queue))
      end
    end

    it "not allows user to checkout someone else's order" do
      order = create(:order)
      allow(Order).to receive(:find).and_return(order)
      get :show, { :order_id => order.id, :id => :billing }
      expect(controller).to set_flash[:alert].to("You are not authorized to access this page.")
    end

    context ":billing step" do
      let(:step_params) { {:order_id => order.id, :id => :billing} }

      it_behaves_like "receives build_or_find methods"
      it_behaves_like "unathenticated users can't checkout"
      it_behaves_like "orders not .in_progress can't be edited"

      it "returns http success" do
        get :show, step_params
        expect(response).to have_http_status(:success)
      end

      it "renders 'billing' page" do
        get :show, step_params
        expect(response).to render_template :billing
      end
    end

    context ":shipping step" do
      let(:step_params) { {:order_id => order.id, :id => :shipping} }

      it_behaves_like "receives build_or_find methods"
      it_behaves_like "unathenticated users can't checkout"
      it_behaves_like "orders not .in_progress can't be edited"

      it "returns http success" do
        get :show, step_params
        expect(response).to have_http_status(:success)
      end

      it "renders 'shipping' page" do
        get :show, step_params
        expect(response).to render_template :shipping
      end
    end

    context ":delivey step" do
      let(:step_params) { {:order_id => order.id, :id => :delivery} }

      it_behaves_like "receives build_or_find methods"
      it_behaves_like "unathenticated users can't checkout"
      it_behaves_like "orders not .in_progress can't be edited"

      it "returns http success" do
        get :show, step_params
        expect(response).to have_http_status(:success)
      end

      it "renders 'delivery' page" do
        get :show, step_params
        expect(response).to render_template :delivery
      end

      it "redirects to :billing when no billing_address" do
        order = create(:order, :user => user)
        allow(Order).to receive(:find).and_return(order)
        get :show, { :order_id => order.id, :id => :delivery }
        expect(response).to redirect_to order_checkout_path(:order_id => order.id, :id => :billing)
      end
    end

    context ":payment step" do
      let(:step_params) { {:order_id => order.id, :id => :payment} }

      it_behaves_like "receives build_or_find methods"
      it_behaves_like "unathenticated users can't checkout"
      it_behaves_like "orders not .in_progress can't be edited"

      it "returns http success" do
        get :show, step_params
        expect(response).to have_http_status(:success)
      end

      it "renders 'payment' page" do
        get :show, step_params
        expect(response).to render_template :payment
      end

      it "redirects to :delivery when no shipping.company" do
        order = create(:order, :user => user)
        allow(Order).to receive(:find).and_return(order)
        get :show, { :order_id => order.id, :id => :payment }
        expect(response).to redirect_to order_checkout_path(:order_id => order.id, :id => :delivery)
      end
    end

    context ":confirm step" do
      let(:step_params) { {:order_id => order.id, :id => :confirm} }

      it_behaves_like "receives build_or_find methods"
      it_behaves_like "unathenticated users can't checkout"
      it_behaves_like "orders not .in_progress can't be edited"

      it "returns http success" do
        get :show, step_params
        expect(response).to have_http_status(:success)
      end

      it "renders 'confirm' page" do
        get :show, step_params
        expect(response).to render_template :confirm
      end

      it "redirects to :payment when no credit_card" do
        order = create(:order, :user => user)
        allow(Order).to receive(:find).and_return(order)
        get :show, { :order_id => order.id, :id => :confirm }
        expect(response).to redirect_to order_checkout_path(:order_id => order.id, :id => :payment)
      end
    end
  end

  describe "PUT #update" do

    before(:each) do 
      allow(Order).to receive(:find).and_return(order)
      allow(order).to receive(:update).and_return(false)
      allow(order).to receive(:build_shipping_address).and_return(shipping_address)
      allow(order).to receive(:billing_address).and_return(billing_address)
      sign_in user
    end

    context ":billing step" do

      before do
        allow(order).to receive(:update).and_return(true)
      end

      let(:step_params) { 
                          {
                            :order_id => order.id, 
                            :id       => :billing, 
                            :order    => 
                                      { 
                                        :billing_address_attributes => 
                                          [
                                            :firstname => billing_address.firstname,
                                            :lastname => billing_address.firstname,
                                            :address => billing_address.address,
                                            :zipcode => billing_address.zipcode,
                                            :city => billing_address.city,
                                            :phone => billing_address.phone,
                                            :country=> billing_address.country
                                          ] 
                                      },
                            :shipping  => checked 
                          } 
                        }
      context "without billing address checkbox checked" do
        let(:checked) { nil }

        it "#update order" do
          expect(order).to receive(:update).with(step_params[:order])
          put :update, step_params
        end

        it "redirects to :shipping" do
          put :update, step_params
          expect(response).to redirect_to order_checkout_path(:order_id => order.id, :id => :shipping)
        end
      end
      context "with billing address checkbox checked" do
        let(:checked) { true }

        it "#update order" do
          expect(order).to receive(:update).with(step_params[:order])
          put :update, step_params
        end

        it "#build_shipping_address" do
          expect(order).to receive(:build_shipping_address)
          put :update, step_params
        end

        it "redirects to :delivery" do
          put :update, step_params
          expect(response).to redirect_to order_checkout_path(:order_id => order.id, :id => :delivery)
        end
      end
    end

    context ":shipping step" do
      let(:step_params) { 
                          {
                            :order_id => order.id, 
                            :id       => :shipping, 
                            :order    => 
                            { 
                              :shipping_address_attributes => 
                              [
                                :firstname => shipping_address.firstname,
                                :lastname => shipping_address.lastname,
                                :address => shipping_address.address,
                                :zipcode => shipping_address.zipcode,
                                :city => shipping_address.city,
                                :phone => shipping_address.phone,
                                :country=> shipping_address.country
                              ] 
                            }
                          } 
                        }
      it "#update order" do
        expect(order).to receive(:update).with(step_params[:order])
        put :update, step_params
      end

      it "redirects to :delivery" do
        put :update, step_params
        expect(response).to redirect_to order_checkout_path(:order_id => order.id, :id => :delivery)
      end    
    end

    context ":delivery step" do
      let(:step_params) { 
                          {
                            :order_id => order.id, 
                            :id       => :delivery, 
                            :order    => 
                            {
                              :shipping_id => create(:shipping).id
                            }
                          } 
                        }
      it "sets delivery for order" do
        put :update, step_params
        expect(order.shipping).not_to be_nil
      end

      it "redirects to :payment" do
        put :update, step_params
        expect(response).to redirect_to order_checkout_path(:order_id => order.id, :id => :payment)
      end
    end

    context ":payment step" do
      let(:step_params) { 
                          {
                            :order_id => order.id, 
                            :id       => :payment, 
                            :order    => 
                            { 
                              :credit_card_attributes => 
                              [
                                :number => credit_card.number,
                                :cvv => credit_card.cvv,
                                :expiration_year => credit_card.expiration_year,
                                :expiration_month => credit_card.expiration_month,
                                :firstname => credit_card.firstname,
                                :lastname => credit_card.lastname,
                              ] 
                            }
                          } 
                        }
      it "#update order" do
        expect(order).to receive(:update).with(step_params[:order])
        put :update, step_params
      end

      it "redirects to :confirm" do
        put :update, step_params
        expect(response).to redirect_to order_checkout_path(:order_id => order.id, :id => :confirm)
      end
    end
  end
end