class UsersController < ApplicationController
  def create
    user = User.new(
      first_name: params["user_first_name"],
      last_name: params["user_last_name"],
      email: params["email"],
      phone: params["phone"],
      password: params["password"],
      password_confirmation: params["password_confirmation"],
      address_line1: params["user_address_line1"],
      address_line2: params["user_address_line2"],
      city: params["user_city"],
      state: params["user_state"],
      zip: params["user_zip"]
    )

    render json: { success_message: "t'works!", status: :ok }
  end

  def show
    @user
  end

  private

  def user_params
    params.require(:user).permit(:user_first_name, :user_last_name, :password, :password_confirmation, :email, :phone, :user_address_line1, :user_address_line2, :user_city, :user_state, :user_zip)
  end
end
