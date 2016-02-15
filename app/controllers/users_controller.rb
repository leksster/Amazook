class UsersController < ApplicationController
  before_action :set_user
  before_action :set_addresses

  def show
  end

  def edit
  end

  def update_billing
    respond_to do |format|
      if @billing.update(billing_params)
        format.html { redirect_to edit_user_path, notice: 'Billing address was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def update_shipping
    respond_to do |format|
      if @shipping.update(shipping_params)
        format.html { redirect_to edit_user_path, notice: 'Shipping address was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def update_password
    respond_to do |format|
      if @user.update_with_password(user_pass_params)
        sign_in @user, :bypass => true
        format.html { redirect_to edit_user_path, notice: 'Password has been changed.' }
      else
        format.html { render :edit }
      end
    end
  end

  def update_email
    respond_to do |format|
      if @user.update(user_email_params)
        format.html { redirect_to edit_user_path, notice: 'Email updated.' }
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
      @billing = Address.where(:user => current_user, :type => 'BillingAddress').first_or_initialize
      @shipping = Address.where(:user => current_user, :type => 'ShippingAddress').first_or_initialize
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
end
