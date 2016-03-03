RSpec.describe RegistrationsController, type: :controller do
  include Devise::TestHelpers
  render_views
  let(:user) { create(:user) }
  let(:billing_address) { create(:billing_address) }
  let(:shipping_address) { create(:shipping_address) }

  describe 'custom actions' do
    before do
      allow(controller).to receive(:current_user).and_return(user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    context 'PUT #update_info' do
      let(:user_params) { 
                          { :user => 
                            { 
                              :billing_address_attributes => 
                              {
                                :firstname => billing_address.firstname,
                                :lastname => billing_address.lastname,
                                :address => billing_address.address,
                                :zipcode => billing_address.zipcode,
                                :city => billing_address.city,
                                :phone => billing_address.phone,
                                :country => '2'
                              }
                            }
                          }
                        }
      it 'assigns @user' do
        put :update_info, user_params
        expect(assigns(:user)).to be_a(User)
      end
      it 'redirects to edit_user_registration_path when successed' do
        put :update_info, user_params
        expect(response).to redirect_to(edit_user_registration_path)
      end
      it 'renders :edit with errors when not successed' do
        put :update_info, :user => {:billing_address_attributes => {}}
        expect(response).to render_template :edit
        expect(user.errors).not_to be_nil
      end
    end

    context 'PUT #update_password' do
      let(:user_params) { 
                          { :user => 
                            { 
                              :current_password => user.password,
                              :password => '11111',
                              :password_confirmation => '11111'
                            }
                          }
                        }
      
      it 'assigns @user' do
        put :update_password, user_params
        expect(assigns(:user)).to be_a(User)
      end

      it 'redirects to edit_user_registration_path when successed' do
        put :update_password, user_params
        expect(response).to redirect_to(edit_user_registration_path)
      end

      it 'renders :edit with errors when not successed' do
        put :update_password, :user => {:current_password => 'wrong'}
        expect(response).to render_template :edit
        expect(user.errors).not_to be_nil
      end
    end
  end
end
