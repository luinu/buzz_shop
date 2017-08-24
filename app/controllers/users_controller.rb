class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @orders = current_user.orders.order(created_at: :desc)
  end

  def address
    @user = current_user
    @user.build_address if @user.address.blank?
  end

  def settings
    @user = current_user
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      flash[:notice] = "Hasło zostało zmienione"
      redirect_to root_path
    else
      render "settings"
    end
  end

  def update_address
    @address = current_user
    if @address.update_attributes(address_params)
      flash[:notice] = "Adres został zmieniony"
      redirect_to root_path
    else
      render "address"
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def address_params
    params.require(:user).permit(
      :address_attributes => [
      :first_name,
      :last_name,
      :city,
      :zip_code,
      :street,
      :email,
      :id
      ])
  end
end
