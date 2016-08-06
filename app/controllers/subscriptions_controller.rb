# == Schema Information
#
# Table name: subscriptions
#
#  id                   :uuid             not null, primary key
#  duration             :integer
#  cost_per_month       :decimal(, )
#  is_gift              :boolean          default(FALSE)
#  gift_message         :text
#  address_line1        :string
#  address_line2        :string
#  city                 :string
#  state                :string
#  zip                  :string
#  user_id              :uuid
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  subscription_cost_id :uuid
#  active               :boolean          default(TRUE)
#  status               :integer          default(0)
#  payment_method_id    :uuid
#

class SubscriptionsController < ApplicationController
  include Constants

  attr_reader :user

  def new
    @user = User.new.as_json
    @child = Child.new.as_json
    @subscription = Subscription.new.as_json
    @states = US_STATES
    @costs = SubscriptionPlan.current.subscription_costs.map do |plan|
      React.camelize_props(plan.as_json(methods: [:description, :per_month]))
    end
  end

  def create
    ActiveRecord::Base.transaction do
      begin
        @user = create_user
        subscription = create_subscription(create_child)

        BraintreeCustomerService.new(
          subscription: subscription,
          nonce: payment_params["nonce"]
        ).execute

        BraintreePaymentService.new(
          subscription: subscription,
          amount: payment_amount
        ).execute_first_payment

        session[:user_id] = @user.id

        render js: "window.location = '/users/#{@user.id}'"
      rescue => e
        render json: { error: e.message }, status: :not_acceptable
        raise ActiveRecord::Rollback
      end
    end
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

  def create_user
    User.create!(
      first_name: user_params["user_first_name"].downcase,
      last_name: user_params["user_last_name"].downcase,
      email: user_params["email"].downcase,
      phone: phone,
      password: user_params["password"],
      password_confirmation: user_params["password_confirmation"],
      address_line1: address_line(user_params["user_address_line1"]),
      address_line2: address_line(user_params["user_address_line2"]),
      city: user_params["user_city"].downcase,
      state: user_params["user_state"],
      zip: user_params["user_zip"]
    )
  end

  def phone
    return unless user_params["phone"]
    user_params["phone"].first.gsub(/[^\d]/, '')
  end

  def child_params
    params.permit(
      :child_first_name,
      :child_last_name,
      :child_birthday,
      :child_gender
    )
  end

  def create_child
    Child.create!(
      first_name: child_params["child_first_name"].downcase,
      last_name: child_params["child_last_name"].downcase,
      birthday: child_params["child_birthday"],
      gender: gender
    )
  end

  def gender
    child_params["child_gender"].downcase == "boy" ? 1 : 0
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

  def create_subscription(child)
    Subscription.create!(
      duration: subscription_params["subscription_type"],
      cost_per_month: payment_amount,
      is_gift: subscription_params["is_gift"],
      gift_message: subscription_params["gift_message"],
      address_line1: address_line(subscription_params["subscription_address_line1"]),
      address_line2: address_line(subscription_params["subscription_address_line2"]),
      city: subscription_params["subscription_city"].downcase,
      state: subscription_params["subscription_state"],
      zip: subscription_params["subscription_zip"],
      user: user,
      children: [child],
      subscription_cost: SubscriptionCost.current
    )
  end

  def random_params
    params.permit(:same_billing_address)
  end

  def address_line(line)
    line.try(:split, " ").try(:map, &:downcase).try(:join, " ")
  end

  def payment_params
    params.permit(:nonce, :payment_type)
  end

  def payment_amount
    cost_map[subscription_params["subscription_type"]]
  end

  def cost_map
    {
      "1" => current_subscription_cost.one_month,
      "3" => current_subscription_cost.three_month,
      "6" => current_subscription_cost.six_month
    }
  end
end
