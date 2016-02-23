class RegistrationsController < Devise::RegistrationsController
  before_action :set_user
  before_action :set_addresses, only: [:edit]

  def show
  end

  def edit
  end

  def update_info
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_user_registration_path, notice: 'Your information was successfully updated.' }
      else
        set_addresses
        format.html { render :edit }
      end
    end
  end

  def update_password
    respond_to do |format|
      if @user.update_with_password(user_params)
        sign_in @user, :bypass => true
        format.html { redirect_to edit_user_registration_path, notice: 'Password has been changed.' }
      else
        set_addresses
        format.html { render :edit }
      end
    end
  end

  protected

  private
    def user_params
      params.require(:user).permit({ :billing_address_attributes => [:firstname, :lastname, :address, :zipcode, :city, :phone, :country]},
                                   { :shipping_address_attributes => [:firstname, :lastname, :address, :zipcode, :city, :phone, :country]}, 
                                     :email,
                                     :password,
                                     :current_password,
                                     :password_confirmation,
                                     :password_confirmation)
    end

    def set_user
      @user = current_user
    end

    def set_addresses
      @user.billing
      @user.shipping
    end
end