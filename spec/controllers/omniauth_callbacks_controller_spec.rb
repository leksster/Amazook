RSpec.describe OmniauthCallbacksController, type: :controller do
  include Devise::TestHelpers
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    :provider => "facebook",
    :uid => "12345",
    :info => {
      :email => "es@sag.ru",
      :name => "Alex S"
    }
  })

  let(:user) { build(:user) }

  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    get :facebook
  end

  describe "GET #facebook" do
    it 'assigns @user' do
      expect(assigns(:user)).not_to be_nil
    end

    it 'signs in and redirects to main page' do
      expect(response).to redirect_to(root_url)
    end

    it 'thows up a flash message' do
      expect(controller).to set_flash[:notice].to("Successfully authenticated from Facebook account.")
    end

    it 'assigns @data' do
      expect(assigns(:data)).not_to be_nil
    end

    it 'user not persisted' do
      allow(User).to receive(:from_omniauth).and_return(user)
      get :facebook    
      expect(response).to redirect_to(new_user_registration_url)
    end
  end
end