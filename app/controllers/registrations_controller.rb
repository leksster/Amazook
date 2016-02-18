class RegistrationsController < Devise::RegistrationsController
  before_action :set_user
  before_action :set_addresses

  def show
  end

  def edit
  end

  def update_billing
    respond_to do |format|
      if @billing.update(billing_params)
        format.html { redirect_to user_edit_path, notice: 'Billing address was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def update_shipping
    respond_to do |format|
      if @shipping.update(shipping_params)
        format.html { redirect_to user_edit_path, notice: 'Shipping address was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def update_password
    respond_to do |format|
      if @user.update_with_password(user_pass_params)
        sign_in @user, :bypass => true
        format.html { redirect_to user_edit_path, notice: 'Password has been changed.' }
      else
        format.html { render :edit }
      end
    end
  end

  def update_email
    respond_to do |format|
      if @user.update(user_email_params)
        format.html { redirect_to user_edit_path, notice: 'Email updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private
    def set_user
      @user = current_user
    end

    def set_addresses
      @billing = current_user.billing
      @shipping = current_user.shipping
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def billing_params
      params.require(:billing_address).permit(:firstname, :lastname, :address, :zipcode, :city, :phone, :country)
    end

    def shipping_params
      params.require(:shipping_address).permit(:firstname, :lastname, :address, :zipcode, :city, :phone, :country)
    end

    def user_email_params
      params.require(:user).permit(:email)
    end

    def user_pass_params
      params.require(:user).permit(:password, :password_confirmation, :current_password)
    end

    def sign_up_params
      params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
    end
end