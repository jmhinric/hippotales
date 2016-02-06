# == Schema Information
#
# Table name: subscriptions
#
#  id             :uuid             not null, primary key
#  duration       :integer
#  cost_per_month :decimal(, )
#  is_gift        :boolean          default(FALSE)
#  gift_message   :text
#  address_line1  :string
#  address_line2  :string
#  city           :string
#  state          :string
#  zip            :string
#  user_id        :uuid
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class SubscriptionsController < ApplicationController
  include Constants

  def new
    @user = User.new
    @child = Child.new
    @months = MONTHS
    @states = US_STATES
  end

  def create
      # :payment_method_nonce => payment_params["nonce"]
    braintree_result = Braintree::Transaction.sale(
      :amount => payment_amount,
      :payment_method_nonce => "fake-valid-visa-nonce"
    )
    if braintree_result
      @user = new_user
      if @user.save!
        session[:user_id] = @user.id
        child = new_child
        if child.save!
          subscription = new_subscription
          subscription.user = @user
          subscription.children << child
        end
      end
    end

    if subscription.save!
      @user.subscriptions << subscription
      @user.save!
      child.save!
    end

    render :js => "window.location = '/users/#{@user.id}'"
  rescue Exception => e
    binding.pry
    render json: { error: e.message }, status: :not_acceptable
  end

  def client_token
    render json: { client_token: Braintree::ClientToken.generate }
  end

  private

  def user_params
    params.permit(
      :user_first_name,
      :user_last_name,
      :password,
      :password_confirmation,
      :email,
      :phone,
      :user_address_line1,
      :user_address_line2,
      :user_city,
      :user_state,
      :user_zip
    )
  end

  def new_user
    User.new(
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
  end

  def child_params
    params.permit(
      :child_first_name,
      :child_last_name,
      :child_birthday,
      :child_gender
    )
  end

  def new_child
    Child.new(
      first_name: params["child_first_name"],
      last_name: params["child_last_name"],
      birthday: params["child_birthday"],
      gender: gender
    )
  end

  def gender
    params["child_gender"] == "Boy" ? 1 : 0
  end

  def subscription_params
    params.permit(
      :subscription_type,
      :subscription_address_line1,
      :subscription_address_line2,
      :subscription_city,
      :subscription_state,
      :subscription_zip,
      :is_gift,
      :gift_message
    )
  end

  def new_subscription
    Subscription.new(
      duration: params["subscription_type"],
      cost_per_month: payment_amount.to_d,
      is_gift: params["is_gift"],
      gift_message: params["gift_message"],
      address_line1: params["subscription_address_line1"],
      address_line2: params["subscription_address_line2"],
      city: params["subscription_city"],
      state: params["subscription_state"],
      zip: params["subscription_zip"]
    )
  end

  def random_params
    params.permit(:same_billing_address)
  end

  def payment_params
    params.permit(:nonce, :payment_type)
  end

  def payment_amount
    cost_map = {
      "1" => "29.95",
      "3" => "27.95",
      "6" => "25.95"
    }
    cost_map[params["subscription_type"]]
  end
end
